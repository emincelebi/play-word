import 'dart:math';

class WordManager {
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
    List<String> splitWord = [];
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
      if (splitWord[a] == ' ') {
        splitWord[a + 1] = "_";
      } else {
        splitWord[a] = "_";
      }
    }
    return splitWord;
  }
}
