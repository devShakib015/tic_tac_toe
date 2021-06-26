import 'dart:io';

import 'player.dart';
import 'winning_pattern.dart';

class Game {
  final Player _player1;
  final Player _player2;

  Game({
    required player1,
    required player2,
  })  : _player1 = player1,
        _player2 = player2;

  final List<String> _board = [for (var i = 0; i < 9; i++) '--'];
  bool _isCurrentPlayer1 = true;
  final List<int> _p1Indexes = [];
  final List<int> _p2Indexes = [];
  int _count = 0;
  bool _runGame = true;

  void get showBoard {
    print('');
    for (var i = 0; i < _board.length; i++) {
      stdout.write('\t${_board[i]} ');
      if (i == 2 || i == 5) {
        print('\n');
      }
    }
    print('\n');
  }

  void updateBoard(int index) {
    _board[index] =
        _isCurrentPlayer1 ? _player1.playingValue : _player2.playingValue;
    _isCurrentPlayer1 ? _p1Indexes.add(index) : _p2Indexes.add(index);
    _count++;
    _nextTurn();
  }

  Player get currentPlayer {
    return _isCurrentPlayer1 ? _player1 : _player2;
  }

  List<int> get filledIndexes {
    var _l = _p1Indexes + _p2Indexes;
    _l.sort();
    return _l;
  }

  void _nextTurn() {
    _isCurrentPlayer1 = !_isCurrentPlayer1;
  }

  bool get runGame {
    return _runGame;
  }

  void get checkWin {
    var _isP1Win = false;
    var _isP2Win = false;

    WinningPattern.pattern.forEach((element) {
      if (element.every((e) => _p1Indexes.contains(e))) {
        _isP1Win = true;
      } else if (element.every((e) => _p2Indexes.contains(e))) {
        _isP2Win = true;
      }
    });

    if (_isP1Win) {
      print('\n### ${_player1.name} wins the game. ###\n');
      _runGame = false;
      print('Final Result - ');
      showBoard;
    } else if (_isP2Win) {
      print('\n### ${_player2.name} wins the game. ###\n');
      _runGame = false;
      print('Final Result - ');
      showBoard;
    } else if (_count == 9) {
      print('\n### Match Draw. ###\n');
      _runGame = false;
      print('Final Result - ');
      showBoard;
    } else {
      print('\n### No winner yet.\n');
    }
  }
}
