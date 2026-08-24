import 'dart:async';
import 'package:flutter/foundation.dart';

class GameLogic extends ChangeNotifier {
  final String player1Symbol;

  late String player2Symbol;

  List<String> board = List.filled(9, '');

  bool isPlayer1Turn = true;
  bool gameOver = false;
  String winnerText = '';

  int seconds = 0;
  Timer? timer;

  GameLogic({required this.player1Symbol}) {
    player2Symbol = player1Symbol == 'X' ? 'O' : 'X';
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!gameOver) {
          seconds++;
          notifyListeners();
        }
      },
    );
  }

  void tapCell(int index) {
    if (gameOver || board[index].isNotEmpty) return;

    board[index] =
        isPlayer1Turn ? player1Symbol : player2Symbol;

    final winner = checkWinner();

    if (winner != null) {
      gameOver = true;
      winnerText = winner == player1Symbol
          ? 'Player 1 Wins!'
          : 'Player 2 Wins!';
      timer?.cancel();
    } else if (!board.contains('')) {
      gameOver = true;
      winnerText = "It's a Draw!";
      timer?.cancel();
    } else {
      isPlayer1Turn = !isPlayer1Turn;
    }

    notifyListeners();
  }

  String? checkWinner() {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final line in lines) {
      final a = board[line[0]];
      final b = board[line[1]];
      final c = board[line[2]];

      if (a != '' && a == b && b == c) {
        return a;
      }
    }

    return null;
  }

  void reset() {
    timer?.cancel();

    board = List.filled(9, '');
    isPlayer1Turn = true;
    gameOver = false;
    winnerText = '';
    seconds = 0;

    startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}