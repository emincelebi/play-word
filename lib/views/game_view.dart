import 'dart:math';
import 'package:flutter/material.dart';
import 'package:play_word/constants/constants.dart';
import 'package:play_word/models/question_model.dart';
import 'package:play_word/services/question_database.dart';
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
  List starQuestions = [];
  List questions = [];
  List answers = [];
  String question = '';
  String answer = '';
  List<String> wordLetters = [];
  List<double> fontSizeOptions = [16, 18, 20, 22, 24];
  late final SharedPreferences _manager;

  @override
  void initState() {
    super.initState();
    queDb = QuestionDatabaseHelper();
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
    starQuestions = await queDb.getStarredQuestions();
    questions = await queDb.getQuestionUnknown(widget.level);
    answers = await queDb.getAnswersUnknown(widget.level);
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

  doControl(String ans) async {
    if (question.toLowerCase() == ans.toLowerCase()) {
      score++;
      await queDb.updateIsKnown(question, 'yes');
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

  updateScore() async {
    String level = '';
    switch (widget.level) {
      case 'a':
        level = 'score';
        break;
      case 'b':
        level = 'score2';
        break;
      case 'c':
        level = 'score3';
        break;
      default:
    }
    int? s;
    s = _manager.getInt(level);
    s ??= 0;
    if (score > s) {
      await _manager.setInt(level, score);
    }
  }

  doControlLife() {
    if (life < 1) {
      updateScore();

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

  Widget showLife() {
    List<Widget> heartIcons = [
      const Text('Life: ', style: TextStyle(fontSize: 15, color: Colors.black)),
    ];

    if (life == 1) {
      heartIcons.add(const Icon(Icons.heart_broken_outlined, color: Colors.red));
    } else {
      for (int i = 0; i < life; i++) {
        heartIcons.add(const Icon(Icons.favorite_outline, color: Colors.red));
      }
    }

    return Row(
      children: heartIcons,
    );
  }

  Widget showLevel() {
    if (widget.level == 'a') {
      return const Text('A LEVEL', style: TextStyle(fontSize: 25, color: Colors.black));
    } else if (widget.level == 'b') {
      return const Text('B LEVEL', style: TextStyle(fontSize: 25, color: Colors.black));
    } else {
      return const Text('C LEVEL', style: TextStyle(fontSize: 25, color: Colors.black));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Word Play'),
        actions: [
          IconButton(
              onPressed: () async {
                String s = await queDb.isKnownQuestion(question) ?? 'yes';
                if (isStar(question)) {
                  queDb.deleteStar(question);
                  starQuestions.remove(question);
                } else {
                  queDb.insertQuestion(QuestionModel(
                      question: question, answer: answer, isKnown: s, isStar: 'yes', level: widget.level));
                  starQuestions.add(question);
                }
                setState(() {});
              },
              icon: isStar(question) ? const Icon(Icons.star) : const Icon(Icons.star_border_outlined)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showLife(),
                  Column(
                    children: [
                      Text('Score: $score', style: const TextStyle(fontSize: 15, color: Colors.black)),
                      Text('   Hint: $hint', style: const TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                ],
              ),
              const Divider(color: Colors.black),
              showLevel(),
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
                        style: TextStyle(fontSize: calculateFontSize(wordLetters.length), color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
              Text(answer, style: TextStyle(fontSize: 15, color: Constants.appBarColorDark)),
              const SizedBox(height: 25),
              TextField(
                keyboardType: TextInputType.multiline,
                controller: textController,
                style: TextStyle(color: Colors.blue.shade500),
                decoration: InputDecoration(
                  labelText: 'Answer',
                  hintText: 'Enter Your Answer',
                  prefixIcon: const Icon(Icons.question_answer_outlined, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800],
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey[400]),
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
              TextButton(
                  onPressed: hint > 0 ? () => takeHint() : null,
                  child: const Text(
                    'Hint',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
