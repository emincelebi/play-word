import 'package:flutter/material.dart';
import 'package:play_word/constants/constants.dart';
import 'package:play_word/services/question_database.dart';
import 'package:play_word/services/star_question_database.dart';

class StarQuestionView extends StatefulWidget {
  const StarQuestionView({super.key});

  @override
  State<StarQuestionView> createState() => _StarQuestionViewState();
}

class _StarQuestionViewState extends State<StarQuestionView> {
  List starQuestion = [];
  List starAnswer = [];
  late StarDatabaseHelper starDb;
  late QuestionDatabaseHelper queDb;

  bool isStar(String name) {
    bool star = starQuestion.contains(name);
    return star;
  }

  @override
  void initState() {
    starDb = StarDatabaseHelper();
    queDb = QuestionDatabaseHelper();
    fetchQuestions();
    super.initState();
  }

  fetchQuestions() async {
    starQuestion = await starDb.getQuestionNames();
    starAnswer = await starDb.getAnswerNames();
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
        Expanded(
          child: starQuestion.isEmpty
              ? Center(
                  child: Text(
                    'you have not star question',
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
                                starDb.deleteStar(starQuestion[index]);
                                starQuestion.remove(starQuestion[index]);
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
