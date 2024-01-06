import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:play_word/constants/a1a2_question_words.dart';
import 'package:play_word/constants/b1b2_question_wrods.dart';
import 'package:play_word/constants/c1_question.dart';
import 'package:play_word/services/question_service.dart';
import 'package:play_word/theme/dark_theme.dart';
import 'package:play_word/theme/light_theme.dart';
import 'package:play_word/views/home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = true;

class _MyAppState extends State<MyApp> {
  late QuestionService qServ;
  AQuestions aQuestions = AQuestions();
  BQuestions bQuestions = BQuestions();
  CQuestions cQuestions = CQuestions();

  @override
  void initState() {
    qServ = QuestionService();
    qServ.addSampleWords(aQuestions.words, 'a');
    qServ.addSampleWords(bQuestions.words, 'b');
    qServ.addSampleWords(cQuestions.words, 'c');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? DarkTheme().theme : LightTheme().theme,
      home: AppTemplate(
        child: const HomeView(),
        toggleTheme: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}

class AppTemplate extends StatelessWidget {
  final Widget child;
  final VoidCallback toggleTheme;

  const AppTemplate({
    Key? key,
    required this.child,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Play'),
        leading: IconButton(
          onPressed: toggleTheme,
          icon: const Icon(Icons.refresh),
        ),
      ),
      body: child,
    );
  }
}
