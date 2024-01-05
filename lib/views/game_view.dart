import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:play_word/models/question_model.dart';
import 'package:play_word/services/question_database.dart';
import 'package:play_word/services/star_question_database.dart';
import 'package:play_word/services/word_manager.dart';
import 'package:play_word/views/game_over_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class GameView extends StatefulWidget {
  GameView({Key? key, this.isim, required this.level}) : super(key: key);
  String? isim;
  String level;
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int life;
  late int score;
  late int hint;
  int starIndex = 0;
  TextEditingController textController = TextEditingController();
  WordManager wManager = WordManager();
  late QuestionDatabaseHelper queDb;
  late StarDatabaseHelper starDb;
  List starQuestions = [];
  List questions = [];
  List answers = [];
  String question = '';
  String answer = '';
  List<String> wordLetters = [];
  List<double> fontSizeOptions = [16, 18, 20, 22, 24];
  late final SharedPreferences _manager;
  List<String> splitWord = [];

  @override
  void initState() {
    super.initState();
    queDb = QuestionDatabaseHelper();
    starDb = StarDatabaseHelper();
    life = 3;
    hint = 3;
    score = 0;
    initilaze();
    fetchQuestions();
  }

  initilaze() async {
    _manager = await SharedPreferences.getInstance();
  }

  fetchQuestions() async {
    starQuestions = await starDb.getQuestionNames();
    questions = await queDb.getQuestionNames(widget.level);
    answers = await queDb.getAnswerNames(widget.level);
    int randomIndex = Random().nextInt(questions.length - 1);
    starIndex = randomIndex;
    answer = answers[randomIndex];
    question = questions[randomIndex];
    setState(() {
      wordLetters = wManager.getRandomWord(question);
    });
  }

  bool isStar(String name) {
    bool star = starQuestions.contains(name);
    return star;
  }

  double calculateFontSize(int wordLength) {
    if (wordLength <= 4) {
      return fontSizeOptions[0];
    } else if (wordLength <= 6) {
      return fontSizeOptions[1];
    } else if (wordLength <= 8) {
      return fontSizeOptions[2];
    } else if (wordLength <= 10) {
      return fontSizeOptions[3];
    } else {
      return fontSizeOptions[4];
    }
  }

  doControl(String ans) {
    if (question.toLowerCase() == ans) {
      score++;
      int s = Random().nextInt(questions.length - 1);
      question = questions[s];
      answer = answers[s];
      setState(() {
        wordLetters = wManager.getRandomWord(question);
      });
      textController.clear();
    } else {
      life--;
    }
    setState(() {});
  }

  doControlLife() async {
    if (life < 1) {
      int? s = _manager.getInt('score');
      s ??= 0;
      if (score > s) {
        await _manager.setInt('score', score);
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GameOverView(score: score, answer: question),
      ));
    }
  }

  takeHint() {
    bool x = wordLetters.contains('_');
    if (hint > 0 && x) {
      setState(() {
        hint--;
        for (int i = 0; i < wordLetters.length; i++) {
          if (wordLetters[i] == "_") {
            wordLetters[i] = question[i];
            break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Play'),
        actions: [
          customIconButton(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Life: $life', style: const TextStyle(fontSize: 15)),
                  Text('Score: $score', style: const TextStyle(fontSize: 15)),
                  Text('Hint: $hint', style: const TextStyle(fontSize: 15)),
                ],
              ),
              const Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: max(1, wordLetters.length),
                  ),
                  itemCount: wordLetters.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Text(
                        wordLetters[index],
                        style: TextStyle(
                          fontSize: calculateFontSize(wordLetters.length),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(answer, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 25),
              TextField(
                keyboardType: TextInputType.multiline,
                controller: textController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.question_answer_outlined),
                  hintText: 'Enter Your Answer',
                  labelText: 'Answer',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (textController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('You must enter something!'),
                      ),
                    );
                  } else {
                    doControl(textController.text);
                    doControlLife();
                  }
                },
                child: const Text('Submit'),
              ),
              TextButton(onPressed: hint > 0 ? () => takeHint() : null, child: const Text('Hint')),
            ],
          ),
        ),
      ),
    );
  }

  IconButton customIconButton() {
    return IconButton(
        onPressed: () async {
          if (isStar(question)) {
            starDb.deleteStar(question);
            starQuestions.remove(question);
          } else {
            int res = await starDb.insertQuestion(QuestionModel(question: question, answer: answer));
            if (res > 0) {
              if (kDebugMode) {
                print('eklenmedi');
              } else {
                if (kDebugMode) {
                  print('eklendi');
                }
              }
            }
            starQuestions.add(question);
          }
          setState(() {});
        },
        icon: isStar(question) ? const Icon(Icons.star) : const Icon(Icons.star_border_outlined));
  }
}
