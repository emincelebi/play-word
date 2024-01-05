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
  int aQuest = 0;
  int bQuest = 0;
  int cQuest = 0;

  @override
  void initState() {
    queDb = QuestionDatabaseHelper();
    fetchNumber();
    super.initState();
  }

  fetchNumber() async {
    aQuest = await queDb.getNumberQuestion('a');
    bQuest = await queDb.getNumberQuestion('b');
    cQuest = await queDb.getNumberQuestion('c');
    setState(() {});
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
                          child: Wrap(
                            children: [
                              ListTile(
                                title: Text('A level: $aQuest'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GameView(level: 'a'),
                                  ));
                                },
                              ),
                              ListTile(
                                title: Text('B level: $bQuest'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GameView(level: 'b'),
                                  ));
                                },
                              ),
                              ListTile(
                                title: Text('C level: $cQuest'),
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
                    // ignore: use_build_context_synchronously
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
