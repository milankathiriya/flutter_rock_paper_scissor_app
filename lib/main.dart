import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int initialIndex = 0;

  int rock = 0;
  int paper = 0;
  int sciesor = 0;

  String humanChoice = "";
  String AIChoice = "";

  String msg = "";
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rock-Paper-Sciesor"),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.amber,
                  Colors.lightBlueAccent,
                ],
              ),
            ),
          ),
        ),
        actions: [
          (initialIndex != 0)
              ? IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      initialIndex = 0;
                      rock = 0;
                      paper = 0;
                      sciesor = 0;

                      humanChoice = "";
                      AIChoice = "";

                      msg = "";
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: IndexedStack(
        index: initialIndex,
        children: [
          // Starting UI
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("Start Game"),
                  onPressed: () {
                    setState(() {
                      initialIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
          // Game UI
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  child: showAIChoice(),
                  height: 250,
                  width: 250,
                ),
                Text(
                  msg,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  child: showMyChoice(),
                  height: 250,
                  width: 250,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            rock = 1;
                            paper = 0;
                            sciesor = 0;
                          });
                          checkWinner();
                        },
                        child: Image.asset("assets/images/rock.png"),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            paper = 1;
                            rock = 0;
                            sciesor = 0;
                          });
                          checkWinner();
                        },
                        child: Image.asset("assets/images/paper.png"),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            sciesor = 1;
                            rock = 0;
                            paper = 0;
                          });
                          checkWinner();
                        },
                        child: Image.asset("assets/images/sciesor.png"),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showMyChoice() {
    if (rock == 1) {
      humanChoice = "rock";
      return Image.asset("assets/images/rock.png");
    }
    if (paper == 1) {
      humanChoice = "paper";
      return Image.asset("assets/images/paper.png");
    }
    if (sciesor == 1) {
      humanChoice = "sciesor";
      return Image.asset("assets/images/sciesor.png");
    }
    return Container();
  }

  Widget showAIChoice() {
    Random random = Random();

    List<Widget> images = [
      Image.asset("assets/images/rock.png"),
      Image.asset("assets/images/paper.png"),
      Image.asset("assets/images/sciesor.png"),
    ];

    int i = random.nextInt(3);

    if (i == 0) {
      AIChoice = "rock";
    }
    if (i == 1) {
      AIChoice = "paper";
    }
    if (i == 2) {
      AIChoice = "sciesor";
    }

    return (rock == 0 && paper == 0 && sciesor == 0) ? Container() : images[i];
  }

  void checkWinner() {
    if (humanChoice == 'rock' && AIChoice == 'sciesor') {
      msg = "You wins...";
      color = Colors.green;
    } else if (humanChoice == 'paper' && AIChoice == 'rock') {
      msg = "You wins...";
      color = Colors.green;
    } else if (humanChoice == 'sciesor' && AIChoice == 'paper') {
      msg = "You wins...";
      color = Colors.green;
    } else if (humanChoice == AIChoice) {
      msg = "Draw...";
      color = Colors.red;
    } else if (AIChoice == 'rock' && humanChoice == 'sciesor') {
      msg = "You lose...";
      color = Colors.red;
    } else if (AIChoice == 'paper' && humanChoice == 'rock') {
      msg = "You lose...";
      color = Colors.red;
    } else if (AIChoice == 'sciesor' && humanChoice == 'paper') {
      msg = "You lose...";
      color = Colors.red;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
