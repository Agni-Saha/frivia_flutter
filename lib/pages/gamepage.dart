import 'package:fifth_app_frivia/provider/gamepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String difficulty;
  const GamePage({
    Key? key,
    required this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? deviceHeight = MediaQuery.of(context).size.height;
    double? deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        difficulty: difficulty.toLowerCase(),
      ),
      child: BuildUI(
        height: deviceHeight,
        width: deviceWidth,
      ),
    );
  }
}

class BuildUI extends StatelessWidget {
  final double? height, width;

  const BuildUI({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        GamePageProvider? pageProvider = context.watch<GamePageProvider>();

        if (pageProvider.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: height! * 0.05,
                ),
                child: GameUI(
                  height: height,
                  width: width,
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}

class GameUI extends StatelessWidget {
  final double? width, height;

  const GameUI({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const QuestionText(),
        Column(
          children: [
            TrueButton(
              height: height,
              width: width,
            ),
            SizedBox(
              height: height! * 0.01,
            ),
            FalseButton(
              height: height,
              width: width,
            ),
          ],
        ),
      ],
    );
  }
}

class QuestionText extends StatelessWidget {
  const QuestionText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageProvider? pageProvider = context.watch<GamePageProvider>();
    return Text(
      pageProvider.getCurrentQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 25,
      ),
    );
  }
}

class TrueButton extends StatelessWidget {
  final double? width, height;
  const TrueButton({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageProvider? pageProvider = context.watch<GamePageProvider>();
    return MaterialButton(
      onPressed: () {
        pageProvider.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: width! * 0.80,
      height: height! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}

class FalseButton extends StatelessWidget {
  final double? width, height;
  const FalseButton({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageProvider? pageProvider = context.watch<GamePageProvider>();
    return MaterialButton(
      onPressed: () {
        pageProvider.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: width! * 0.80,
      height: height! * 0.10,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
