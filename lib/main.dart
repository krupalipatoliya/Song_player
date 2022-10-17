import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediabooster_project1/pages/audiopage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context)=> const Project1(),
        'music_player' : (context)=> const AppMusicPlayer(),
      },
    ),
  );
}


