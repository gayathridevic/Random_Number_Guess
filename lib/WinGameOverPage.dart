import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numberguessinggame/SplashScreen.dart';
import 'package:numberguessinggame/util/Theme.dart';

enum GameResult { win, gameover }

class MyApp extends StatelessWidget {
  bool didWin = true; // Set this variable based on the game result.
  final int randomNumber;

  MyApp({required this.randomNumber});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WinGameOverPage(
        result: didWin ? GameResult.win : GameResult.gameover,
        randomNumber:
            randomNumber, // Pass the randomNumber to the WinGameOverPage.
      ),
    );
  }
}

class WinGameOverPage extends StatefulWidget {
  final GameResult result;
  final int randomNumber;

  const WinGameOverPage(
      {Key? key, required this.result, required this.randomNumber})
      : super(key: key);

  @override
  _WinGameOverPageState createState() => _WinGameOverPageState();
}

class _WinGameOverPageState extends State<WinGameOverPage> {
  bool showWinPage = true;

  void togglePage() {
    setState(() {
      showWinPage = !showWinPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          showWinPage ? ColorConstants.PrimaryColor : HexColor('#00008B'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              showWinPage
                  ? (widget.result == GameResult.win
                      ? 'assets/images/win.png'
                      : 'assets/images/gameover.png')
                  : 'assets/images/gameover.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Text(
                showWinPage
                    ? (widget.result == GameResult.win
                        ? 'Win The Match....'
                        : 'Game Over....!')
                    : 'Game Over....',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: showWinPage ? Colors.white : Colors.red,
                ),
              ),
            ),
            SizedBox(
                height:
                    20), // Add some spacing between win/lose message and feedback message
            showWinPage
                ? widget.result == GameResult.win
                    ? Text(
                        'Congratulations! You won!', // Customize this message as needed
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        'My Random number is: ${widget.randomNumber}', // Customize this message as needed
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                : Text(
                    'Game Over....', // Optional: Add a default message for the Game Over page
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ]),
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
    );
  }
}
