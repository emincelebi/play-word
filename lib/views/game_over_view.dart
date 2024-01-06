import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameOverView extends StatelessWidget {
  GameOverView({super.key, required this.score, required this.answer});
  int score;
  String answer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Word Play'),
          ),
          body: SafeArea(
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Doğru Cevap: $answer',
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 60),
                const Text(
                  "Game Over!",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                Text("Skorun: $score"),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Back to home')),
              ]),
            ),
          )),
    );
  }
}
