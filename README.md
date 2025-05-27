# swift-mastermind-game


# Mastermind CLI (Swift)

A simple terminal-based implementation of the classic **Mastermind** code-breaking game, written in Swift. This version uses an external REST API to manage game sessions and evaluate guesses.

---

## 🚀 Features

- **Interactive CLI**: Play directly in your terminal.
- **API-backed**: Leverages the [Mastermind API](https://mastermind.darkube.app) for session management and guess evaluation.
- **Peg Feedback**: Returns black pegs (correct digit & position) and white pegs (correct digit, wrong position).
- **Exit Anytime**: Type `exit` to quit the game.

---

## 🛠 Prerequisites

- **Swift 5.8+**  
- **Swift Package Manager** (bundled with Swift)  
- **Network Access** (to reach the Mastermind API)

---

## 📥 Installation

```bash
# Clone the repository
git clone https://github.com/YourUsername/MastermindCLI.git
cd MastermindCLI

# Build the project
swift build

# Run the game
swift run
⚙️ Usage
Start the game

css
Copy
Edit
Welcome to Mastermind 🕵️
Your game ID: e3f1a2b4
Enter a 4-digit guess

yaml
Copy
Edit
Enter your 4-digit guess (digits 1–6), or type 'exit' to quit: 1234
Feedback: BW
B = Black peg (correct digit & position)

W = White peg (correct digit, wrong position)

Repeat until you receive BBBB (four black pegs) or type exit.

