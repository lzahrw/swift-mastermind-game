// Mastermind.swift
// Mastermind game implementation in the terminal using Swift and a backend API

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// Data structures for API
struct CreateGameResponse: Codable {
    let game_id: String
}

struct GuessRequest: Codable {
    let game_id: String
    let guess: String
}

struct GuessResponse: Codable {
    let black: Int
    let white: Int
}

// Start a new game and return the game ID
func startGame() -> String? {
    let url = URL(string: "https://mastermind.darkube.app/game")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    var gameId: String?
    let semaphore = DispatchSemaphore(value: 0)
    let session = URLSession(configuration: .default)

    session.dataTask(with: request) { data, response, error in
        defer { semaphore.signal() }
        if let error = error {
            print("Error starting game: \(error.localizedDescription)")
            return
        }
        guard let data = data else {
            print("No data in response when starting game.")
            return
        }
        // Uncomment to debug raw JSON:
        // if let raw = String(data: data, encoding: .utf8) {
        //     print("Raw startGame response:", raw)
        // }
        guard let resp = try? JSONDecoder().decode(CreateGameResponse.self, from: data) else {
            print("Invalid response when decoding startGame.")
            return
        }
        gameId = resp.game_id
    }.resume()

    semaphore.wait()
    return gameId
}

// Send a guess to the API and receive feedback
func sendGuess(gameId: String, guessDigits: [Int]) -> (black: Int, white: Int)? {
    let url = URL(string: "https://mastermind.darkube.app/guess")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let guessString = guessDigits.map(String.init).joined()
    let body = GuessRequest(game_id: gameId, guess: guessString)
    request.httpBody = try? JSONEncoder().encode(body)

    var feedback: (Int, Int)?
    let semaphore = DispatchSemaphore(value: 0)
    let session = URLSession(configuration: .default)

    session.dataTask(with: request) { data, response, error in
        defer { semaphore.signal() }
        if let error = error {
            print("Error sending guess: \(error.localizedDescription)")
            return
        }
        guard let data = data else {
            print("No data in response when sending guess.")
            return
        }
        // Uncomment to debug raw JSON:
        // if let raw = String(data: data, encoding: .utf8) {
        //     print("Raw guess response:", raw)
        // }
        guard let resp = try? JSONDecoder().decode(GuessResponse.self, from: data) else {
            print("Invalid response when decoding guess.")
            return
        }
        feedback = (resp.black, resp.white)
    }.resume()

    semaphore.wait()
    return feedback
}

// Main game loop
func main() {
    print("Welcome to Mastermind! 🕵️")

    guard let gameId = startGame() else {
        print("Failed to start a new game. Exiting.")
        return
    }
    print("Game ID: \(gameId)")

    while true {
        print("Enter your 4-digit guess (digits 1-6) or 'exit' to quit:", terminator: " ")
        guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else { continue }
        if input.lowercased() == "exit" {
            print("Game over. Goodbye!")
            break
        }

        let digits = input.compactMap { Int(String($0)) }
        if digits.count != 4 || digits.contains(where: { $0 < 1 || $0 > 6 }) {
            print("Invalid input! Enter exactly 4 digits between 1 and 6.")
            continue
        }

        guard let feedback = sendGuess(gameId: gameId, guessDigits: digits) else {
            continue
        }

        let blackPegs = String(repeating: "B", count: feedback.black)
        let whitePegs = String(repeating: "W", count: feedback.white)
        print("Feedback: \(blackPegs)\(whitePegs)")

        if feedback.black == 4 {
            let codeString = digits.map(String.init).joined()
            print("Congratulations! You've cracked the code: \(codeString) 🎉")
            break
        }
    }
}

// Run the game
main()
