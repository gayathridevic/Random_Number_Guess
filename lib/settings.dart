import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:numberguessinggame/util/Theme.dart';

void main() {
  runApp(settings());
}

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool _isChecked = false;
  bool isChecked = false;

  AudioPlayer audioPlayer = AudioPlayer();

  void playAudio() async {
    //audioPlayer.play(AssetSource('assets/audio/music.mp3'));
    await audioPlayer.play(AssetSource('audio/music.mp3'));
    // audioPlayer.play();
  }

  void stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

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
        backgroundColor: ColorConstants.PrimaryColor,
        body: Center(
          child: Container(
            width: 250,
            height: 250,
            child: Card(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    height: 100,
                    color: ColorConstants.SecondaryColor,
                    child: Card(
                      color: ColorConstants.SecondaryColor,
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
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue!;
                                if (isChecked) {
                                  playAudio();
                                } else {
                                  stopAudio();
                                }
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final player = AudioPlayer();
                            player.setSource(AssetSource('music.mp3'));
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
                            value: _isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue!;
                                if (_isChecked) {
                                  playAudio();
                                } else {
                                  stopAudio();
                                }
                              });
                            },
                          ),
                        )
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
