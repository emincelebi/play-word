import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:play_word/constants/constants.dart';
import 'package:play_word/models/question_model.dart';
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

  bool isStar(String name) {
    bool star = starQuestion.contains(name);
    return star;
  }

  @override
  void initState() {
    starDb = StarDatabaseHelper();
    fetchQuestions();
    super.initState();
  }

  fetchQuestions() async {
    starQuestion = await starDb.getQuestionNames();
    starAnswer = await starDb.getAnswerNames();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Word Play"),
        ),
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
                            trailing: IconButton(
                                onPressed: () async {
                                  if (isStar(starQuestion[index])) {
                                    starDb.deleteStar(starQuestion[index]);
                                    starQuestion.remove(starQuestion[index]);
                                  } else {
                                    int res = await starDb.insertQuestion(
                                        QuestionModel(question: starQuestion[index], answer: starAnswer[index]));
                                    if (res > 0) {
                                      if (kDebugMode) {
                                        print('eklenmedi');
                                      } else {
                                        if (kDebugMode) {
                                          print('eklendi');
                                        }
                                      }
                                    }
                                    starQuestion.add(starQuestion[index]);
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
