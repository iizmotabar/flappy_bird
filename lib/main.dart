import 'dart:async';

import 'package:flappybird/barriers.dart';
import 'package:flappybird/myBird.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static double birdYAxis = 0.0;
  double time = 0.0;
  double height = 0.0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;

  static double barrierXone = 1.0;
  double barrierXtwo = barrierXone + 1.6;

  //! Jump Functionality
  void jump() {
    if (gameHasStarted) {
      setState(() {
        time = 0;
        initialHeight = birdYAxis;
        // height = 0.0;
      });
    }
  }

  // @override
  // void initState() {
  //   startGame();
  //   super.initState();
  // }

  void startGame() {
    if (birdYAxis != 1.0) {
      print('This was called!');
      gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 60), (Timer timer) {
        time += 0.05;

        //* Creating artificial gravity
        height = -4.9 * time * time + 2.8 * time;
        setState(() {
          birdYAxis = initialHeight - height;
          barrierXone -= 0.05;
          barrierXtwo -= 0.05;
        });

        setState(() {
          if (barrierXone < -2) {
            barrierXone += 3.5;
          } else {
            barrierXone -= 0.05;
          }

          if (barrierXtwo < -2) {
            barrierXtwo += 3.5;
          } else {
            barrierXtwo -= 0.05;
          }
        });

        if (birdYAxis > 1) {
          timer.cancel();
          gameHasStarted = false;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Text(
                  'Game Over',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                );
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                        alignment: Alignment(0, birdYAxis),
                        duration: const Duration(milliseconds: 0),
                        color: Colors.blue,
                        child: const MyBird()),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: !gameHasStarted
                          ? const Text('T A P TO P L A Y',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ))
                          : const Text(''),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 130.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.brown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'SCORE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'BEST',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              '10',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
