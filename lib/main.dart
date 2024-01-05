import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_word/services/question_words.dart';
import 'package:play_word/theme/dark_theme.dart';
import 'package:play_word/theme/light_theme.dart';
import 'package:play_word/views/home_view.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = true;

class _MyAppState extends State<MyApp> {
  late QuestionService qServ;

  @override
  void initState() {
    qServ = QuestionService();
    qServ.addSampleWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('tr', 'TR'),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
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