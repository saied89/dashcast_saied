import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: DashcastApp());
  }
}

class DashcastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(flex: 8, child: Placeholder()),
        Flexible(flex: 2, child: AudioControl()),
      ],
    );
  }
}

class AudioControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaybackButtons();
  }
}

class PlaybackButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaybackButton();
  }
}

class PlaybackButton extends StatefulWidget {
  @override
  _PlaybackButtonState createState() => _PlaybackButtonState();
}

class _PlaybackButtonState extends State<PlaybackButton> {
  var _isPlaying = false;

  final _url =
      "https://incompetech.com/music/royalty-free/mp3-royaltyfree/Discovery%20Hit.mp3";

  FlutterSound _flutterSound = new FlutterSound();

  double _playposition = 0;
  Stream<PlayStatus> _playSubscription;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Slider(
          onChanged: (p) {},
          value: _playposition,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.fast_rewind),
              onPressed: () {},
            ),
            IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (!_isPlaying)
                    _play();
                  else
                    _pause();
                  setState(() => _isPlaying = !_isPlaying);
                }),
            IconButton(
              icon: Icon(Icons.fast_forward),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  _play() async {
//    Directory tempDir = await getTemporaryDirectory();
//    File fin = await File ('${tempDir.path}/flutter_sound-tmp.aac');
    String result = await _flutterSound.startPlayer(_url);
    _playSubscription = _flutterSound.onPlayerStateChanged
      ..listen((ps) {
        if (ps != null) {
          print("${ps.currentPosition} << ${ps.duration}");
          setState(() {
            _playposition = ps.currentPosition / ps.duration;
          });
        }
      });
  }

  _pause() async {
    String result = await _flutterSound.pausePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterSound.stopPlayer();
  }
}
