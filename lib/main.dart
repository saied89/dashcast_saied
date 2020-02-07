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
        body: Center(child: PlaybackButton()));
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

  FlutterSound flutterSound = new FlutterSound();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon:Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow
        ),
        onPressed: () {
          if (!_isPlaying)
            _play();
          else
            _pause();
          setState(() => _isPlaying = !_isPlaying);
        });
  }

  _play() async{
//    Directory tempDir = await getTemporaryDirectory();
//    File fin = await File ('${tempDir.path}/flutter_sound-tmp.aac');
    String result = await flutterSound.startPlayer(_url);

  }

  _pause() async{
    String result = await flutterSound.pausePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterSound.stopPlayer();
  }
}
