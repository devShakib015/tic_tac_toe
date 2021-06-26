import 'dart:io';
import 'game.dart';
import 'player.dart';

const String p1Value = 'X';
const String p2Value = 'O';

void main(List<String> arguments) {
  print('_____________ INITIALIZING TIC TAC TOE ___________\n');
  print('Make Two Players and Play!!!\n');
  print('Player 1 [You are X] - What\'s your name?');
  var p1Name = stdin.readLineSync();

  print('\nPlayer 2 [You are O]- What\'s your name?');
  var p2Name = stdin.readLineSync();

  var game = Game(
    player1: Player(
        name: p1Name! == '' ? 'Player 1' : p1Name, playingValue: p1Value),
    player2: Player(
        name: p2Name! == '' ? 'Player 2' : p2Name, playingValue: p2Value),
  );

  while (game.runGame) {
    print('_____________ TIC TAC TOE ___________');
    game.showBoard;
    print(
        "${game.currentPlayer.name}'s turn - ${game.currentPlayer.playingValue}");
    print('Which number are you giving?');
    var number = int.tryParse(stdin.readLineSync()!) ?? -1;
    if (number != -1) {
      if (game.filledIndexes.contains(number - 1)) {
        print('The Number you selected is already filled! try another one');
      } else if (number < 1 || number > 9) {
        print('The choice is out of range!');
      } else {
        game.updateBoard(number - 1);
        game.checkWin;
      }
    } else {
      print('The choice is not a number!!!');
    }
  }
}
