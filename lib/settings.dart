import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:audioplayers/audioplayers.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final player = AudioCache();

  bool _isChecked = false;
  bool _isChecked1 = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Go back
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: HexColor('#00008B'),
        body: Center(
          child: Container(
            width: 250,
            height: 250,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    height: 100,
                    color: HexColor('#F06313'),
                    child: Card(
                      color: HexColor('#F06313'),
                      child: Icon(
                        Icons.settings,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(
                      children: [
                        Text(
                          'Sound',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isChecked = newValue!;
                                  });
                                }))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            AudioPlayer().play(AssetSource('audio/music.mp3'));
                          },
                          child: Text(
                            'Vibrate',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                value: _isChecked1,
                                onChanged: (bool? newValue1) {
                                  setState(() {
                                    _isChecked1 = newValue1!;
                                  });
                                }))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
