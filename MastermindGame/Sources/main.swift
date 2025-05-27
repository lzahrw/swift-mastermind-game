import Foundation

func generateSecretCode() -> [Int] {
    return (0..<4).map { _ in Int.random(in: 1...6) }
}

func computeFeedback(secret: [Int], guess: [Int]) -> (black: Int, white: Int) {
    var black = 0
    var white = 0
    var secretRemaining: [Int] = []
    var guessRemaining: [Int] = []

    for i in 0..<4 {
        if secret[i] == guess[i] {
            black += 1
        } else {
            secretRemaining.append(secret[i])
            guessRemaining.append(guess[i])
        }
    }

    for digit in guessRemaining {
        if let index = secretRemaining.firstIndex(of: digit) {
            white += 1
            secretRemaining.remove(at: index)
        }
    }

    return (black, white)
}

func main() {
    print("Welcome to Mastermind!")
    let secretCode = generateSecretCode()

    while true {
        print("Enter your 4-digit guess (digits 1-6), or type 'exit' to quit:", terminator: " ")
        guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            continue
        }

        if input.lowercased() == "exit" {
            print("Game over. Goodbye!")
            break
        }

        let digits = input.compactMap { Int(String($0)) }
        if digits.count != 4 || digits.contains(where: { $0 < 1 || $0 > 6 }) {
            print("Invalid input! Please enter exactly 4 digits, each between 1 and 6.")
            continue
        }

        let feedback = computeFeedback(secret: secretCode, guess: digits)

        let blackPegs = String(repeating: "B", count: feedback.black)
        let whitePegs = String(repeating: "W", count: feedback.white)
        print("Feedback: \(blackPegs)\(whitePegs)")

        if feedback.black == 4 {
            let codeString = digits.map(String.init).joined()
            print("Congratulations! You cracked the code: \(codeString)")
            break
        }
    }
}

main()
