import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_word/views/game_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GameView(),
                    ));
                  },
                  child: const Text('Play')),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final int? score = prefs.getInt('score') ?? 0;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text('Highest score: $score'),
                      ),
                    );
                  },
                  child: const Text('Highest Score')),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)),
                child: const Text('Exit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
