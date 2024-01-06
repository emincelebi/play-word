import 'package:flutter/material.dart';
import 'package:play_word/constants/constants.dart';
import 'package:play_word/services/question_database.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final QuestionDatabaseHelper dbHelper = QuestionDatabaseHelper();
  List<String> knownQuestions = [];
  List<String> questions = [];
  List<String> knownAnswers = [];
  List<String> answers = [];
  String selectedLevel = 'a';

  @override
  void initState() {
    super.initState();
    getKnownQuestions();
  }

  bool isKnown(String name) {
    bool known = knownQuestions.contains(name);
    return known;
  }

  Future<void> getKnownQuestions() async {
    questions = await dbHelper.getKnownQuestionsByLevel(selectedLevel);
    answers = await dbHelper.getKnownQuestionAnswers(selectedLevel);
    setState(() {
      knownQuestions = questions;
      Set<String> uniqueQuestion = Set.from(knownQuestions);
      knownQuestions = uniqueQuestion.toList();
      knownAnswers = answers;
      Set<String> uniqueAnswer = Set.from(knownAnswers);
      knownAnswers = uniqueAnswer.toList();
    });
  }

  Future<Widget> getLevel(String question) async {
    String? level = await dbHelper.getQuestionLevel(question);
    if (level == 'a') {
      return const Text('A\nLEVEL');
    } else if (level == 'b') {
      return const Text('B\nLEVEL');
    } else {
      return const Text('C\nLEVEL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              value: 'a',
              groupValue: selectedLevel,
              onChanged: (value) {
                setState(() {
                  selectedLevel = value ?? 'a';
                  getKnownQuestions();
                });
              },
            ),
            const Text('A'),
            Radio<String>(
              value: 'b',
              groupValue: selectedLevel,
              onChanged: (value) {
                setState(() {
                  selectedLevel = value ?? 'a';
                  getKnownQuestions();
                });
              },
            ),
            const Text('B'),
            Radio<String>(
              value: 'c',
              groupValue: selectedLevel,
              onChanged: (value) {
                setState(() {
                  selectedLevel = value ?? 'a';
                  getKnownQuestions();
                });
              },
            ),
            const Text('C'),
          ],
        ),
        Expanded(
          child: knownQuestions.isEmpty
              ? Center(
                  child: Text(
                    'no questions you know yet at this level',
                    style: TextStyle(
                      color: Constants.appBarColorDark,
                      fontSize: 21,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: knownQuestions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(knownQuestions[index]),
                        subtitle: Text(knownAnswers[index]),
                        leading: FutureBuilder(
                          future: getLevel(knownQuestions[index]),
                          builder: (context, AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return snapshot.data ?? const SizedBox();
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              if (isKnown(knownQuestions[index])) {
                                dbHelper.deleteKnown(knownQuestions[index]);
                                knownQuestions.remove(knownQuestions[index]);
                                knownAnswers.remove(knownAnswers[index]);
                              }
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  },
                ),
        )
      ],
    ));
  }
}
