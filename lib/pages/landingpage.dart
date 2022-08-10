import 'package:fifth_app_frivia/pages/gamepage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String difficultyText = "Easy";
  late double deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Title(
                difficulty: difficultyText,
              ),
              DifficultySlider(notifyParent: onChangedState),
              SendButton(
                height: deviceHeight,
                width: deviceWidth,
                difficultyText: difficultyText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChangedState(value) {
    setState(() {
      difficultyText = value;
    });
  }
}

class Title extends StatelessWidget {
  final String difficulty;
  const Title({
    Key? key,
    required this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
          ),
        ),
        Text(
          difficulty,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class DifficultySlider extends StatefulWidget {
  final Function(String) notifyParent;
  const DifficultySlider({
    Key? key,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<DifficultySlider> createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  double difficultyLevel = 0.0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: difficultyLevel,
      min: 0.0,
      max: 2.0,
      divisions: 2,
      label: "Difficulty",
      onChanged: onChangedState,
    );
  }

  void onChangedState(value) {
    setState(() {
      difficultyLevel = value;
    });

    String temp;
    if (value == 0.0) {
      temp = "Easy";
    } else if (value == 1.0) {
      temp = "Medium";
    } else {
      temp = "Hard";
    }

    widget.notifyParent(temp);
  }
}

class SendButton extends StatelessWidget {
  final double height, width;
  final String difficultyText;
  const SendButton({
    Key? key,
    required this.difficultyText,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GamePage(
                difficulty: difficultyText,
              );
            },
          ),
        );
      },
      color: Colors.blue,
      minWidth: width * 0.80,
      height: height * 0.08,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
