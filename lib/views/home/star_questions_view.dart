import 'package:flutter/material.dart';
import 'package:play_word/constants/constants.dart';
import 'package:play_word/services/question_database.dart';

class StarQuestionView extends StatefulWidget {
  const StarQuestionView({super.key});

  @override
  State<StarQuestionView> createState() => _StarQuestionViewState();
}

class _StarQuestionViewState extends State<StarQuestionView> {
  List starQuestion = [];
  List starAnswer = [];
  late QuestionDatabaseHelper queDb;
  String selectedLevel = 'a';

  bool isStar(String name) {
    bool star = starQuestion.contains(name);
    return star;
  }

  @override
  void initState() {
    queDb = QuestionDatabaseHelper();
    fetchQuestions();
    super.initState();
  }

  fetchQuestions() async {
    starQuestion = await queDb.getStarredQuestionsByLevel(selectedLevel);
    starAnswer = await queDb.getStarredQuestionAnswersByLevel(selectedLevel);
    setState(() {});
  }

  Future<Widget> getLevel(String question) async {
    String? level = await queDb.getQuestionLevel(question);
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
                  fetchQuestions();
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
                  fetchQuestions();
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
                  fetchQuestions();
                });
              },
            ),
            const Text('C'),
          ],
        ),
        Expanded(
          child: starQuestion.isEmpty
              ? Center(
                  child: Text(
                    'you have not star question at this level',
                    style: TextStyle(
                      color: Constants.appBarColorDark,
                      fontSize: 21,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: starQuestion.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(starQuestion[index]),
                        subtitle: Text(starAnswer[index]),
                        leading: FutureBuilder(
                          future: getLevel(starQuestion[index]),
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
                              if (isStar(starQuestion[index])) {
                                await queDb.deleteStar(starQuestion[index]);
                                starQuestion.remove(starQuestion[index]);
                                starAnswer.remove(starAnswer[index]);
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.star)),
                      ),
                    );
                  },
                ),
        )
      ],
    ));
  }
}
