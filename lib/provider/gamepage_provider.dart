import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  BuildContext context;
  List? questions;
  int currentQuestionCount = 0;
  int maxQuestionCount = 5;
  int score = 0;
  String difficulty = "easy";

  GamePageProvider({
    required this.context,
    required this.difficulty,
  }) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    dio.options.queryParameters = {
      "amount": maxQuestionCount,
      "difficulty": difficulty,
      "type": "boolean"
    };
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await dio.get("");
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return parse(questions![currentQuestionCount]["question"]).body!.innerHtml;
  }

  void answerQuestion(String answer) async {
    bool isCorret =
        questions![currentQuestionCount]["correct_answer"] == answer;

    if (isCorret) score++;

    currentQuestionCount++;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            isCorret ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
          backgroundColor: isCorret ? Colors.green : Colors.red,
        );
      },
    );

    final navigator = Navigator.of(context);
    await Future.delayed(
      const Duration(seconds: 1),
    );
    navigator.pop();

    if (currentQuestionCount == maxQuestionCount) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          content: Text(
            "Score: $score/$maxQuestionCount",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );

    final navigator = Navigator.of(context);
    await Future.delayed(
      const Duration(seconds: 3),
    );
    navigator.pop();
    navigator.pop();
  }

  void updateDifficulty(String str) {
    difficulty = str.toString().toLowerCase();
    notifyListeners();
  }
}
