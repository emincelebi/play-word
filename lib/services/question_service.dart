import 'package:flutter/foundation.dart';
import 'package:play_word/models/question_model.dart';
import 'package:play_word/services/question_database.dart';

class QuestionService {
  QuestionDatabaseHelper queDb = QuestionDatabaseHelper();

  Future<void> addSampleWords(Map<String, String> words, String level) async {
    bool doesExist = false;
    switch (level) {
      case 'a':
        doesExist = await queDb.doesQuestionExistByWord("WELL");
        break;
      case 'b':
        doesExist = await queDb.doesQuestionExistByWord("ELABORATE ON");
        break;
      case 'c':
        doesExist = await queDb.doesQuestionExistByWord("APPROACH");
      default:
    }

    if (!doesExist) {
      for (var entry in words.entries) {
        String word = entry.key;
        String answer = entry.value;

        bool doesExist = await queDb.doesQuestionExistByWord(word);
        if (!doesExist) {
          int insertedId = await queDb.insertQuestion(
            QuestionModel(question: word, answer: answer, level: level, isKnown: 'not', isStar: 'not'),
          );
          if (insertedId != -1) {
            if (kDebugMode) {
              print('Kelime eklendi: ID - $insertedId /  $word - $answer');
            }
          } else {
            if (kDebugMode) {
              print('Kelime eklenirken bir hata oluştu.');
            }
          }
        } else {
          if (kDebugMode) {
            print('Kelime zaten var: $word');
          }
        }
      }
    } else {
      if (kDebugMode) {
        print("already have database");
      }
    }
  }
}
