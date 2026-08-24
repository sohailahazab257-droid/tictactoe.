import 'package:flutter/material.dart';
import 'game_logic.dart';
import 'game_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameLogic? game;

  void startGame(String symbol) {
    setState(() {
      game?.dispose();
      game = GameLogic(player1Symbol: symbol);
    });
  }

  @override
  void dispose() {
    game?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),

      appBar: AppBar(
        backgroundColor: const Color(0xff151515),
        leading: const Icon(Icons.menu),
        title: const Text('Flutter - Tic Tac Toe'),
      ),

      body: Column(
        children: [
          const Spacer(),

          if (game == null)
            chooseCard()
          else
            GameCard(game: game!),

          const Spacer(),

          bottomButtons(),
        ],
      ),
    );
  }

  Widget chooseCard() {
    return Container(
      width: 135,
      height: 285,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tic-Tac-Toe',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            'Pick who goes first!',
            style: TextStyle(fontSize: 10),
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              chooseButton('X', Colors.red),
              const SizedBox(width: 8),
              chooseButton('O', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget chooseButton(String text, Color color) {
    return GestureDetector(
      onTap: () => startGame(text),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        50,
        45,
        50,
        40,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () => startGame('X'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff075487),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Log in',
            style: TextStyle(fontSize: 19),
          ),
        ],
      ),
    );
  }
}