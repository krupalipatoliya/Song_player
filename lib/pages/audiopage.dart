import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../modals/rainbowmusic_modal.dart';

class Project1 extends StatefulWidget {
  const Project1({Key? key}) : super(key: key);

  @override
  State<Project1> createState() => _Project1State();
}

class _Project1State extends State<Project1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "RAINBOW MUSIC",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: l1
              .map(
                (e) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('music_player');

                    songIndex = l1.indexOf(e);

                    print(songIndex);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 3,
                    shadowColor: Colors.white,
                    child: Container(
                      height: 100,
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(e.image),
                          ),
                          Container(
                            height: 70,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.songname,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  e.description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: e.colors,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

int songIndex = 0;

class AppMusicPlayer extends StatefulWidget {
  const AppMusicPlayer({Key? key}) : super(key: key);

  @override
  State<AppMusicPlayer> createState() => _AppMusicPlayerState();
}

class _AppMusicPlayerState extends State<AppMusicPlayer> {
  bool isPlaying = true;
  bool isVolume = true;
  final assetsAudioPlayer = AssetsAudioPlayer();
  double currentPositionInSeconds = 0;
  double songDurationInSeconds = 0;
  String currentPosition = "0:0:0";
  String songDuration = "0:0:0";

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Playlist(
        audios: l1
            .map((e) => Audio(
                  e.song,
                  metas: Metas(
                    title: e.songname,
                    artist: e.description,
                    album: "none",
                    image:
                        MetasImage.network(e.image), //can be MetasImage.network
                  ),
                ))
            .toList(),
        startIndex: songIndex,
      ),
      showNotification: true,
      autoStart: true,
    );

    assetsAudioPlayer.current.listen((Playing? playing) {
      songDuration = playing!.audio.duration.toString().split(".")[0];
      songDurationInSeconds = playing.audio.duration.inSeconds.toDouble();
      setState(() {});
    });

    assetsAudioPlayer.currentPosition.listen((Duration? duration) {
      currentPosition = duration.toString().split(".")[0];
      currentPositionInSeconds = duration!.inSeconds.toDouble();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await assetsAudioPlayer.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Now Playing",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(

                image: NetworkImage(l1[songIndex].image),
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken)
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(l1[songIndex].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  l1[songIndex].songname,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  l1[songIndex].description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Transform.scale(
                      scale: 1.5,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: ()  async {
                          await assetsAudioPlayer.previous();
                          if(songIndex>0){
                            songIndex--;
                          }
                          setState(() {});
                        },
                        icon:  const Icon(Icons.stop,color: Colors.white,),
                      ),
                    ),
                    const SizedBox(width: 50,),
                    Transform.scale(
                      scale: 2.5,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          await assetsAudioPlayer.playOrPause();
                          isPlaying = !isPlaying;
                          setState(() {});
                        },
                        icon:  Icon((isPlaying)?Icons.pause:Icons.play_arrow, color: Colors.white,),
                      ),
                    ),
                    const SizedBox(width: 50,),
                    Transform.scale(
                      scale: 1.5,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          (isVolume) ? await assetsAudioPlayer.setVolume(0) : await assetsAudioPlayer.setVolume(1);
                          setState(() {
                            isVolume =! isVolume;
                          });
                        },
                        icon:  (isVolume) ? const Icon(Icons.volume_up,color:  Colors.white,) : const Icon(Icons.volume_off, color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                Slider(
                    thumbColor: Colors.green,
                    activeColor: Colors.green,
                    inactiveColor:  const Color(0xffEFF1F7) ,
                    value: currentPositionInSeconds,
                    min: 0,
                    max: songDurationInSeconds,
                    onChanged: (val){
                      setState(() {
                        assetsAudioPlayer.seek(Duration(seconds: val.toInt()));
                      });
                    }
                ),
                Align(alignment: const Alignment(0.8,0), child: Text("$currentPosition / $songDuration", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Scaffold(
// body: Container(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Container(
// margin: const EdgeInsets.only(bottom: 50),
// height: MediaQuery.of(context).size.width*0.5,
// width: MediaQuery.of(context).size.width*0.5,
// decoration: BoxDecoration(
// color: Colors.white,
// image: DecorationImage(
// fit: BoxFit.cover,
// image: NetworkImage(l1[songIndex].image),
// ),
// borderRadius: BorderRadius.circular(20),
// boxShadow: [
// BoxShadow(
// color: Colors.black.withOpacity(0.10),
// blurRadius: 20,
// offset: const Offset(0,-4),
// spreadRadius: 0
// )
// ]
// ),
// ),
// Text(l1[songIndex].songname,style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500,color: Colors.black87),),
// const SizedBox(height: 10,),
// Text(l1[songIndex].description, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black87),),
// const SizedBox(height: 50,),
// Container(
// padding: const EdgeInsets.all(10),
// height: MediaQuery.of(context).size.height*0.35,
// width: MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: const BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
// boxShadow: [
// BoxShadow(
// color: Colors.black.withOpacity(0.10),
// blurRadius: 20,
// offset: const Offset(0,-4),
// spreadRadius: 0
// )
// ]
// ),
// alignment: Alignment.center,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 25),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [

// ],
// ),
// ),


// ],
// ),
// ),
// ],
// ),
// height: MediaQuery.of(context).size.height,
// width: MediaQuery.of(context).size.width,
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// colors: [
// Color(0xffF9F9FB),
// Color(0xFFEFF1F3),
// ],
// ),
// ),
// ),
// ),
