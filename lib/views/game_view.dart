import 'dart:math';
import 'package:flutter/material.dart';
import 'package:play_word/services/question_database.dart';
import 'package:play_word/views/game_over_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameView extends StatefulWidget {
  GameView({Key? key, this.isim}) : super(key: key);
  String? isim;
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int life;
  late int score;
  late int hint;
  TextEditingController textController = TextEditingController();
  late QuestionDatabaseHelper queDb;
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
    questions = await queDb.getQuestionNames();
    answers = await queDb.getAnswerNames();
    int randomIndex = Random().nextInt(questions.length - 1);
    answer = answers[randomIndex];
    question = questions[randomIndex];
    setState(() {
      wordLetters = getRandomWord(question);
    });
  }

  List<String> getRandomWord(String word) {
    List<String> words = [];

    if (word.length >= 10) {
      words = getRandomCensor(5, word);
    } else if (word.length >= 8) {
      words = getRandomCensor(4, word);
    } else if (word.length >= 6) {
      words = getRandomCensor(3, word);
    } else if (word.length >= 4) {
      words = getRandomCensor(2, word);
    } else {
      words = getRandomCensor(1, word);
    }
    return words;
  }

  List<String> getRandomCensor(int x, String word) {
    switch (x) {
      case 1:
        splitWord = forLoop(1, word);
        break;
      case 2:
        splitWord = forLoop(2, word);
        break;
      case 3:
        splitWord = forLoop(3, word);
        break;
      case 4:
        splitWord = forLoop(4, word);
        break;
      case 5:
        splitWord = forLoop(5, word);
        break;
      default:
    }

    return splitWord;
  }

  List<String> forLoop(int c, String word) {
    int a;
    int b;
    List<String> splitWord = [];
    splitWord = word.split('');
    for (b = 0; b < c; b++) {
      a = Random().nextInt(word.length - 1);
      splitWord[a] = "*";
    }
    return splitWord;
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
        wordLetters = getRandomWord(question);
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

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GameOverView(score: score, answer: question),
      ));
    }
  }

  takeHint() {
    if (hint > 0) {
      hint--;
      for (int i = 0; i < splitWord.length; i++) {
        if (splitWord[i] == "*") {
          splitWord[i] = question[i];
          setState(() {});
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Play'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.star)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Life: $life', style: const TextStyle(fontSize: 15)),
              widget.isim != null ? Text('Player: ${widget.isim}') : const SizedBox.shrink(),
              Text('Score: $score', style: const TextStyle(fontSize: 15)),
              Text('Hint: $hint', style: const TextStyle(fontSize: 15)),
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
              Text(
                answer,
                style: const TextStyle(fontSize: 15),
              ),
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
              const SizedBox(
                height: 15,
              ),
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
                onPressed: () {
                  takeHint();
                },
                child: const Text('Hint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
