import 'dart:async';

import 'package:path/path.dart';
import 'package:play_word/models/question_model.dart';
import 'package:sqflite/sqflite.dart';

class QuestionDatabaseHelper {
  static Database? _database;
  static const String tableName = 'questions';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbpath = join(path, '$tableName.db');
    return await openDatabase(dbpath, version: 1, onCreate: _onCreate);
  }

  Future<FutureOr<void>> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT,
        answer TEXT,
        level TEXT
      )
      ''');
  }

  Future<int> insertQuestion(QuestionModel question) async {
    final db = await database;
    return await db.insert(tableName, question.toJson());
  }

  Future<List<String>> getQuestionNames(String level) async {
    final db = await database;
    var res = await db.query(tableName, where: "level = ?", whereArgs: [level]);

    List<String?> questionNames = res.isNotEmpty ? res.map((e) => QuestionModel.fromJson(e).question).toList() : [];

    List<String> filteredQuestionNames = questionNames.where((name) => name != null).map((e) => e!).toList();

    return filteredQuestionNames;
  }

  Future<String?> getQuestionLevel(String name) async {
  final db = await database;
  var res = await db.query(
    tableName,
    columns: ['level'],
    where: 'question = ?',
    whereArgs: [name],
  );
  
  if (res.isNotEmpty) {
    return res.first['level'] as String?;
  } else {
    return null;
  }
}


  Future<List<String>> getAnswerNames(String level) async {
    final db = await database;
    var res = await db.query(tableName, where: "level = ?", whereArgs: [level]);

    List<String?> answerNames = res.isNotEmpty ? res.map((e) => QuestionModel.fromJson(e).answer).toList() : [];

    List<String> filteredAnswerNames = answerNames.where((name) => name != null).map((e) => e!).toList();

    return filteredAnswerNames;
  }

  Future<bool> doesQuestionExistByWord(String word) async {
    final db = await database;
    var res = await db.query(
      tableName,
      where: 'question = ?',
      whereArgs: [word],
    );
    return res.isNotEmpty;
  }

  Future<int> getNumberQuestion(String level) async {
    final db = await database;
    var res = await db.query(tableName, where: "level = ?", whereArgs: [level]);

    List<String?> questionNames = res.isNotEmpty ? res.map((e) => QuestionModel.fromJson(e).question).toList() : [];

    List<String> filteredQuestionNames = questionNames.where((name) => name != null).map((e) => e!).toList();

    return filteredQuestionNames.length;
  }

  Future<void> clearTable() async {
    final db = await QuestionDatabaseHelper().database;
    await db.delete(QuestionDatabaseHelper.tableName);
  }

  Future<void> deleteDatabasee() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, '$tableName.db');
    await deleteDatabase(dbPath);
  }
}
