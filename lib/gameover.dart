import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numberguessinggame/SplashScreen.dart';

void main() {
  runApp(gameover());
}

class gameover extends StatefulWidget {
  const gameover({Key? key}) : super(key: key);

  @override
  State<gameover> createState() => _gameoverState();
}

class _gameoverState extends State<gameover> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: HexColor('#00008B'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/gameover.png', width: 200, height: 200),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Game Over....',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Image.asset('assets/images/restart.png'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Instruction()),
            );
          },
        ),
      ),
    );
  }
}
