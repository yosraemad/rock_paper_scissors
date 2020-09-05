import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/src/enum/game_options.dart';
import 'package:rock_paper_scissors/src/screens/game_screen.dart';
import 'package:rock_paper_scissors/src/widgets/stats.dart';

class MainScreen extends StatefulWidget {
  static Stats statsWidget = Stats();
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      floatingActionButton: MainScreen.statsWidget,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Choose an option!",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(GameOptions.ROCK)));
                },
                elevation: 2,
                minWidth: 200,
                height: 40,
                color: Colors.grey[200].withOpacity(0.3),
                child: Text("Rock"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(GameOptions.PAPER)));
                },
                elevation: 2,
                minWidth: 200,
                height: 40,
                color: Colors.grey[200].withOpacity(0.3),
                child: Text("Paper"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(GameOptions.SCISSORS)));
                },
                elevation: 2,
                minWidth: 200,
                height: 40,
                color: Colors.grey[200].withOpacity(0.3),
                child: Text("Scissors"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
