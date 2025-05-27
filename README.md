
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
git clone https://github.com/YourUsername/mastermind-cli-swift.git
cd mastermind-cli-swift

# Build the project
swift build

# Run the game
swift run

```

Understand the feedback

- B = Black peg (correct digit & position)
- W = White peg (correct digit, wrong position)
```bash
Win or Quit
Repeat until you receive BBBB (four black pegs), or type exit to quit.

```
