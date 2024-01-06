import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_word/services/question_database.dart';
import 'package:play_word/views/add_view.dart';
import 'package:play_word/views/game_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonsView extends StatefulWidget {
  const ButtonsView({super.key});

  @override
  State<ButtonsView> createState() => _ButtonsViewState();
}

class _ButtonsViewState extends State<ButtonsView> {
  late QuestionDatabaseHelper queDb;

  late final SharedPreferences _manager;

  @override
  void initState() {
    queDb = QuestionDatabaseHelper();
    initilaze();
    super.initState();
  }

  initilaze() async {
    _manager = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  final int score = prefs.getInt('score') ?? 0;
                  final int score2 = prefs.getInt('score2') ?? 0;
                  final int score3 = prefs.getInt('score3') ?? 0;

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'A Level Highest score: $score',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _manager.setInt('score', 0);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                            const Divider(height: 20.0, thickness: 2.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'B Level Highest score: $score2',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _manager.setInt('score2', 0);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                            const Divider(height: 20.0, thickness: 2.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'C Level Highest score: $score3',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _manager.setInt('score3', 0);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                });
              },
              child: const Text('Highest Score'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddView(),
                  ));
                },
                child: const Text('Add Question')),
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
    );
  }
}
