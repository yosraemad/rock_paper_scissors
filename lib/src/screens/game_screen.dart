import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/src/enum/game_options.dart';
import 'package:rock_paper_scissors/src/screens/main_screen.dart';
import 'package:rock_paper_scissors/src/widgets/stats.dart';

class GameScreen extends StatefulWidget {
  final GameOptions chosenGame;
  GameScreen(this.chosenGame);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  GameOptions computerOption;
  bool done;

  @override
  void initState() {
    super.initState();
    done = false;
    computerOption = chooseRandomly();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: -100, end: 100)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    TickerFuture tickerFuture = controller.repeat(reverse: true);
    tickerFuture.timeout(Duration(milliseconds: 500 * 6), onTimeout: () {
      controller.forward(from: 0.5);
      controller.stop(canceled: true);
      setState(() {
        done = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Center(
            child: Transform.translate(
              offset: Offset(0, animation.value),
              child: done
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getRandomImage(),
                        getTextResults(),
                      ],
                    )
                  : Image.asset("assets/images/rock.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextResults() {
    if ((widget.chosenGame == GameOptions.ROCK &&
            computerOption == GameOptions.SCISSORS) ||
        (widget.chosenGame == GameOptions.PAPER &&
            computerOption == GameOptions.ROCK) ||
        (widget.chosenGame == GameOptions.SCISSORS &&
            computerOption == GameOptions.PAPER)) {
      MainScreen.statsWidget.incrementWin();
      return Text(
        "You win! 😎",
        style: TextStyle(fontSize: 30),
      );
    } else if (widget.chosenGame == computerOption) {
      MainScreen.statsWidget.incrementDraw();
      return Text(
        "It's a draw! 😜",
        style: TextStyle(fontSize: 30),
      );
    } else {
      MainScreen.statsWidget.incrementLoss();
      return Text(
        "You lost 😕",
        style: TextStyle(fontSize: 30),
      );
    }
  }

  Widget getRandomImage() {
    if (computerOption == GameOptions.ROCK)
      return Image.asset("assets/images/rock.png");
    else if (computerOption == GameOptions.PAPER)
      return Image.asset("assets/images/paper.png");
    else if (computerOption == GameOptions.SCISSORS)
      return Image.asset("assets/images/scissors.png");
    else
      return null;
  }

  GameOptions chooseRandomly() {
    Random rand = Random();
    int result = rand.nextInt(3);
    switch (result) {
      case 0:
        return GameOptions.ROCK;
      case 1:
        return GameOptions.PAPER;
      case 2:
        return GameOptions.SCISSORS;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
