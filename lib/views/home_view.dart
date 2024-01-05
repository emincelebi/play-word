import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_word/services/question_database.dart';
import 'package:play_word/views/game_view.dart';
import 'package:play_word/views/star_questions_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late QuestionDatabaseHelper queDb;

  @override
  void initState() {
    queDb = QuestionDatabaseHelper();
    super.initState();
  }

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
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              ListTile(
                                title: const Center(child: Text('A level', style: TextStyle(color: Colors.black))),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GameView(level: 'a'),
                                  ));
                                },
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 1,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                              ListTile(
                                title: const Center(child: Text('B level', style: TextStyle(color: Colors.black))),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GameView(level: 'b'),
                                  ));
                                },
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 1,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                              ListTile(
                                title: const Center(child: Text('C level', style: TextStyle(color: Colors.black))),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GameView(level: 'c'),
                                  ));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Play')),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final int score = prefs.getInt('score') ?? 0;
                    final int score2 = prefs.getInt('score2') ?? 0;
                    final int score3 = prefs.getInt('score3') ?? 0;
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Column(
                          children: [
                            Text('A Level Highest score: $score'),
                            Text('B Level Highest score: $score2'),
                            Text('C Level Highest score: $score3'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Highest Score')),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StarQuestionView(),
                    ));
                  },
                  child: const Text('Stars Questions')),
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
