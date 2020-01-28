import "package:console/console.dart";
import 'package:reverse_number_guesser/console_utils.dart';

const maxGuess = 100;

int guesses;
int min;
int max;
int lastGuess;

void main() {
  Console.init();

  newGame();

}

void newGame() {
  initGame();
  printGuess();
}

void initGame() {
  guesses = 0;
  min = 0;
  max= maxGuess;

  Console.setTextColor(ConsoleColor.blue.index);
  Console.write("\nThink of a number between 1 and $maxGuess, and  I'll try to guess it!");
  Prompter("\nPress <ENTER> once you've got your number in mind").promptSync();
}

int guess(int min, int max) => (min + max) ~/ 2;

void printGuess() {
  lastGuess= guess(min, max);

  Console.write("\nI guess ");
  highlight("$lastGuess.", 1);

  guesses++;

  printMenu();
}

void printMenu() {

  consoleNewLine();
  consoleNewLine();

  printMenuItem(phrase: "Guess is too high", highlightIndex: 13);
  printMenuItem(phrase: "Guess is too low", highlightIndex: 13);
  printMenuItem(phrase: "Guess is correct", highlightIndex: 9);

  final input = promptForString("\n\nSelection...");

  switch(input) {
    case 'h':
      max = lastGuess;
      printGuess();
      break;
    case 'l':
      min = lastGuess;
      printGuess();
      break;
    case 'c':
      Console.setTextColor(ConsoleColor.green.index);
      Console.write("\nI win! And it only took me $guesses guesses.");
      Console.setTextColor(ConsoleColor.magenta.index);
      if (Prompter("\n\nWould you like to play again? ").askSync()) {
        newGame();
      }
        break;
    default:
      Console.setTextColor(ConsoleColor.red.index);
      Console.write("\nWhat the hell are you talking about? Try again, pal!");
      printMenu();
      break;
  }
}

void highlight(String value, [int colorID = 3]) {
  Console.setTextColor(colorID);
  Console.write(value);
  Console.setTextColor(ConsoleColor.white.index);
}
