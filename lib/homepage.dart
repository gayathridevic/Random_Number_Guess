import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numberguessinggame/util/Theme.dart';
import 'dart:math';
import 'package:numberguessinggame/settings.dart';
import 'package:numberguessinggame/WinGameOverPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTryCount = 0;
  final int maxTriesAllowed = 5;
  bool _validate = false;
  int previousNumber = -1;

  final maxTriesCount = ValueNotifier(5);

  final guessedNumber = TextEditingController();

  // Generate a random number between 1 and 20
  Random ran = Random();
  int randomNumber = 0;

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    randomNumber = ran.nextInt(20) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.PrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorConstants.kThirdSecondaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => settings(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Icon(
                          Icons.settings,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: ColorConstants.kThirdSecondaryColor,
              child: Image.asset(
                'assets/images/number.gif',
                height: 350,
                width: 400,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Guess The Number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: ValueListenableBuilder(
                            valueListenable: maxTriesCount,
                            builder: (context, value, _) {
                              return Text(
                                value.toString(),
                                key: UniqueKey(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.SecondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 70,
              width: 200,
              child: Card(
                color: Colors.white,
                child: TextField(
                  controller: guessedNumber,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorText: _validate ? 'Please enter something' : null,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 150,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  _submit();
                  previousNumber = maxTriesCount.value;
                  maxTriesCount.value = previousNumber - 1;
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor('F06313'))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    int guess = int.parse(guessedNumber.text);

    if (guess > 20 || guess < 1) {
      makeToast("Choose a number between 1 and 20");
      guessedNumber.clear();
      return;
    }

    currentTryCount++;
    if (currentTryCount == maxTriesAllowed && guess != randomNumber) {
      makeToast(
          "Game Over! Your Number of Tries is: $currentTryCount. My number is: $randomNumber");
      currentTryCount = 0;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WinGameOverPage(
            result: GameResult.gameover,
            randomNumber: randomNumber,
          ),
        ),
      );
      generateRandomNumber();
      guessedNumber.clear();
      return;
    }

    if (guess > randomNumber) {
      makeToast("Lower! Number of Tries is: $currentTryCount");
    } else if (guess < randomNumber) {
      makeToast("Higher! Number of Tries is: $currentTryCount");
    } else {
      makeToast("That's right. You Win! Number of Tries is: $currentTryCount");
      currentTryCount = 0;
      generateRandomNumber();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WinGameOverPage(
            result: GameResult.win,
            randomNumber: randomNumber,
          ),
        ),
      );
    }

    guessedNumber.clear();
  }

  // Function to display feedback as an alert dialog
  void makeToast(String feedback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 100,
          height: 100,
          child: AlertDialog(
            backgroundColor: HexColor('F06313'),
            title: Center(
              child: Column(
                children: [
                  Text(
                    feedback,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
