# Bomb-Bonanza

After completing the Stanford Swift CS193p Course (https://www.youtube.com/watch?v=bqu6BquVi2M&list=PLpGHT1n4-mAsxuRxVPv7kj4-dQYoC3VVu), I built a reinterpretation of the popular Minesweeper game.

<!-- ABOUT THE PROJECT -->
## About The Project
Bomb Bonanza's adventure is unlike any other, offering an exciting, fun-filled experience. Gamblers will tread their way through the minefield to come out victorious. Bomb Bonanza is much like the old-time classic Minesweeper. Players, must move across the field and avoid the bombs. The layout of the game has been skillfully designed to allow seamless play and easy understanding. Players get a fantastic return of 97%

### Bottom Lines from the Project:
The main takeaway from this project is a better and much clearer understanding of the Swift programming language. Studying theory is only the foundation. Putting the knowledge into action is the main part of learning *how* to program.

List of key details that I got a deeper understanding of:
  - MVVM Design Pattern: (View, ViewModel, Model)
  - Functional programming paradigm
  - Swift UI Elements (Buttons, Alerts, Images, Stacks, Picker)
  - View Modifiers
  - ObservedObject
  - Animations
  - User Defaults
  - Sounds (.onTapGesture)
  - Struct, Classes, Optionals, Enums
  - Functions

## Screenshots
### Main screen
The game lets the user choose a number of bombs and an amount to bet. The greater the bet and number of bombs, the greater the payout and the risk.

![alt text](https://github.com/oprisor-raul/Bomb-Bonanza/blob/main/Screenshots/home_screen.png)

### Actual gameplay
The user needs to choose a card to pick and hope that it will not be a bomb. After being satisfied with the sum won the user can cash out.
![alt text](https://github.com/oprisor-raul/Bomb-Bonanza/blob/main/Screenshots/gameplay.png)
### Lost Screen
All gambled money will be instantly lost when the user taps the card of a bomb.
![alt text](https://github.com/oprisor-raul/Bomb-Bonanza/blob/main/Screenshots/lost.png)
### Won Screen
Similar to the main screen present when the user launches the game, the number of bombs and the amount to bet can be adjusted.
![alt text](https://github.com/oprisor-raul/Bomb-Bonanza/blob/main/Screenshots/won.png)

## Formula for calculating the payout:
(Return: 97%)
To make sure the user gets a favorable payout according to the odds the following formula was used:

### calculatePayout(bet) = 0.97 * 1/Proability(nr_bombs)

Proability(nr_bombs) = :  `for index in 0...numberOfChosenCards {
                                probability = probability * (25 - index - numberOfBombs) / (25 - index)}`

## Built With
This project is crafted from the ground up with Swift.

[![Swift][Swift-Programming-Language]][Swift-url]

## Installation
To get a local copy up and running follow these simple example steps.
1. Clone the repo
   ```sh
   git clone https://github.com/oprisor-raul/Bomb-Bonanza.git
   ```
2. Open the project in Xcode
  * Open Xcode and select "Open a project or file."
    
3. Build and run the app
  * Select your target device or simulator in Xcode.
  * Hit the "Run" button

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

[Swift-Programming-Language]: https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white
[Swift-url]: https://developer.apple.com/swift/
