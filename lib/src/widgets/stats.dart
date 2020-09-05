import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stats extends StatefulWidget {
  final StatsState state = StatsState();
  incrementLoss() {
    state.incrementLoseCounter();
  }

  incrementWin() {
    state.incrementWinCounter();
  }

  incrementDraw() {
    state.incrementDrawCounter();
  }

  @override
  StatsState createState() => state;
}

class StatsState extends State<Stats> {
  int loseCounter;
  int winCounter;
  int drawCounter;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loseCounter = prefs.getInt('lose') ?? 0;
    winCounter = (prefs.getInt('win') ?? 0);
    drawCounter = (prefs.getInt('draw') ?? 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("wins:   $winCounter"),
          Text("loses:  $loseCounter"),
          Text("draw:   $drawCounter"),
        ],
      ),
    );
  }

  incrementLoseCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loseCounter = loseCounter + 1;
    await prefs.setInt('lose', loseCounter);
    setState(() {});
  }

  incrementWinCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    winCounter = winCounter + 1;
    await prefs.setInt('win', winCounter);
    setState(() {});
  }

  incrementDrawCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    drawCounter = drawCounter + 1;
    await prefs.setInt('draw', loseCounter);
    setState(() {});
  }
}
