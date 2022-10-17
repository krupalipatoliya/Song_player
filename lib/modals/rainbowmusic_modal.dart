import 'package:flutter/material.dart';

class Music {
  String image;
  String songname;
  String description;
  String song;
  Color colors;

  Music({
    required this.image,
    required this.songname,
    required this.description,
    required this.song,
    required this.colors,
  });
}

List<Music> l1 = [
  Music(
    image: "https://static.toiimg.com/photo/msid-70987848/70987848.jpg",
    songname: "Ghungroo",
    description: "Arijit Singh, Shilpa | \nVishal & Shekhar, Kumaar",
    song: "assets/songs/Ghungroo.mp3",
    colors: Colors.blue,
  ),
  Music(
    image: "https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_717050216.jpg",
    songname: "Toofan",
    description: "Prashanth Neel | Ravi Basrur",
    song: "assets/songs/Toofan - KGF Chapter-2.mp3",
    colors: Colors.deepOrangeAccent,
  ),
  Music(
    image: "https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_685847752.jpg",
    songname: "Whistle Baja 2.0",
    description: "Neeti Mohan | Mika Singh",
    song: "assets/songs/Whistle Baja 2.0.mp3",
    colors: Colors.redAccent,
  ),
  Music(
    image: "https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_217802429.jpg",
    songname: "Mitra Re",
    description: "Arijit Singh | Jasleen Royal",
    song: "assets/songs/Mitra Re.mp3",
    colors: Colors.greenAccent,
  ),
  Music(
    image: "https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_1718338069.jpg",
    songname: "Mehram",
    description: "Sachet Tandon",
    song: "assets/songs/Mehram.mp3",
    colors: Colors.amberAccent,
  ),
  Music(
    image: "https://pagalsong.in/uploads//thumbnails/300x300/radhe_shyam_poster.jpg",
    songname: "Labon Pe Naam",
    description: "Armaan Malik",
    song: "assets/songs/Labon Pe Naam.mp3",
    colors: Colors.deepPurpleAccent,
  ),
  Music(
    image: "https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_584891650.jpg",
    songname: "Lehra Do",
    description: "Pritam | Arijit Singh",
    song: "assets/songs/Lehra Do.mp3",
    colors: Colors.lightGreen,
  ),
];
