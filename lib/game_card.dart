import 'package:flutter/material.dart';
import 'game_logic.dart';

class GameCard extends StatelessWidget {
  final GameLogic game;

  const GameCard({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: game,
      builder: (context, _) {
        return Container(
          width: 135,
          height: 285,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xffffd92f),
                Color(0xffff351f),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              timeBox(),

              const SizedBox(height: 10),

              Text(
                game.gameOver
                    ? game.winnerText
                    : game.isPlayer1Turn
                        ? "Player 1's Turn"
                        : "Player 2's Turn",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: board(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget timeBox() {
    return Container(
      width: 115,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '${game.seconds} sec',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget board() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final value = game.board[index];

          return GestureDetector(
            onTap: () => game.tapCell(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: index % 3 != 2
                      ? BorderSide(
                          color: Colors.grey.shade400,
                        )
                      : BorderSide.none,
                  bottom: index < 6
                      ? BorderSide(
                          color: Colors.grey.shade400,
                        )
                      : BorderSide.none,
                ),
              ),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: value == 'X'
                        ? Colors.red
                        : const Color(0xff70a844),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
