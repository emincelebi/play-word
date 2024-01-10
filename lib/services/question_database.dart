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
        level TEXT,
        isKnown TEXT,
        isStar TEXT
      )
      ''');
  }

  Future<int> insertQuestion(QuestionModel question) async {
    final db = await database;
    return await db.insert(tableName, question.toJson());
  }

  //KNOWN SERVİCE

  Future<List<String>> getKnownQuestionAnswers(String level) async {
    final db = await QuestionDatabaseHelper().database;
    var res = await db.query(
      QuestionDatabaseHelper.tableName,
      columns: ['answer'],
      where: 'isKnown = ? AND level = ?',
      whereArgs: ['yes', level],
    );

    List<String> knownQuestionAnswers =
        res.isNotEmpty ? res.map((e) => QuestionModel.fromJson(e).answer).whereType<String>().toList() : [];

    return knownQuestionAnswers;
  }

  Future<int> deleteKnown(String question) async {
    final db = await database;
    return await db.update(
      tableName,
      {'isKnown': 'no'},
      where: 'question = ?',
      whereArgs: [question],
    );
  }

  Future<int> updateIsKnown(String name, String isKnown) async {
    final db = await database;
    return await db.update(
      tableName,
      {'isKnown': isKnown},
      where: 'question = ?',
      whereArgs: [name],
    );
  }

  Future<List<String>> getKnownQuestionsByLevel(String level) async {
    final db = await QuestionDatabaseHelper().database;
    var res = await db.query(
      QuestionDatabaseHelper.tableName,
      columns: ['question'],
      where: 'isKnown = ? AND level = ?',
      whereArgs: ['yes', level],
    );

    List<String?> knownQuestions = res.isNotEmpty ? res.map((e) => QuestionModel.fromJson(e).question).toList() : [];

    List<String> filteredKnownQuestions = knownQuestions.where((name) => name != null).map((e) => e!).toList();

    return filteredKnownQuestions;
  }

  Future<String?> isKnownQuestion(String question) async {
    final db = await QuestionDatabaseHelper().database;
    var res = await db.query(
      QuestionDatabaseHelper.tableName,
      columns: ['isKnown'],
      where: 'question = ?',
      whereArgs: [question],
    );

    if (res.isNotEmpty) {
      return res.first['isKnown'] as String?;
    } else {
      return null;
    }
  }

  //GENERAL QUESTİON SERVİCE

  Future<bool> doesQuestionExistByWord(String word) async {
    final db = await database;
    var res = await db.query(
      tableName,
      where: 'question = ?',
      whereArgs: [word],
    );
    return res.isNotEmpty;
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

  Future<List<String>> getStarredQuestions() async {
    final db = await QuestionDatabaseHelper().database;
    var res = await db.query(
      QuestionDatabaseHelper.tableName,
      columns: ['question'],
      where: 'isStar = ?',
      whereArgs: ['yes'],
    );

    List<String> starredQuestions = res.isNotEmpty ? res.map((e) => e['question'] as String).toList() : [];

    return starredQuestions;
  }

  Future<List<String>> getStarredQuestionsByLevel(String level) async {
    final db = await QuestionDatabaseHelper().database;
    var res = await db.query(
      QuestionDatabaseHelper.tableName,
      columns: ['question'],
      where: 'isStar = ? AND level = ?',
      whereArgs: ['yes', level],
    );

    List<String> starredQuestions = res.isNotEmpty ? res.map((e) => e['question'] as String).toList() : [];

    return starredQuestions;
  }

  Future<List> getQuestionUnknown(String level) async {
    final db = await database;
    var res =
        await db.query(tableName, columns: ['question'], where: "isKnown = ? AND level = ?", whereArgs: ['not', level]);

    List unknownQuestions = res.isNotEmpty ? res.map((e) => e['question'] as String).toList() : [];

    return unknownQuestions;
  }

  //GENERAL ANSWER SERVİCE
  Future<List<String>> getAnswerNames(String level) async {
    final db = await database;
    var res = await db.query(tableName, where: "level = ?", whereArgs: [level]);

    List<String?> answerNames = res.isNotEmpty ? res.map((e) => QuestionModel.fromJson(e).answer).toList() : [];

    List<String> filteredAnswerNames = answerNames.where((name) => name != null).map((e) => e!).toList();

    return filteredAnswerNames;
  }

  Future<List> getAnswersUnknown(String level) async {
    final db = await database;
    var res =
        await db.query(tableName, columns: ['answer'], where: "isKnown = ? AND level = ?", whereArgs: ['not', level]);

    List unknownAnswers = res.isNotEmpty ? res.map((e) => e['answer'] as String).toList() : [];

    return unknownAnswers;
  }

  // STAR SERVİCE

  Future<void> deleteStar(String question) async {
    final db = await QuestionDatabaseHelper().database;
    await db.update(
      QuestionDatabaseHelper.tableName,
      {'isStar': 'not'},
      where: 'question = ?',
      whereArgs: [question],
    );
  }

  Future<List<String>> getStarredQuestionAnswersByLevel(String level) async {
    final db = await QuestionDatabaseHelper().database;
    var res = await db.query(
      QuestionDatabaseHelper.tableName,
      columns: ['answer'],
      where: 'isStar = ? AND level = ?',
      whereArgs: ['yes', level],
    );

    List<String> starredQuestionAnswers = res.isNotEmpty ? res.map((e) => e['answer'] as String).toList() : [];

    return starredQuestionAnswers;
  }

  Future<void> deleteDatabasee() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, '$tableName.db');
    await deleteDatabase(dbPath);
  }
}
