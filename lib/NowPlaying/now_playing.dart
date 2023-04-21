import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/DB/functions/function_fav.dart';
import 'package:project_one_tuneup/NowPlaying/artwork_widget.dart';
import 'package:project_one_tuneup/NowPlaying/botumsheet.dart';
import 'package:project_one_tuneup/NowPlaying/playing_controll.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';
import 'package:project_one_tuneup/minipleyer/mini_pleyer.dart';
import 'package:project_one_tuneup/songlist/all_songs_list.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({
    super.key,
    required this.songmodel,
    this.count = 0,
  });

  final List<SongModel> songmodel;
  final int count;
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  int currentindex = 0;
  bool firstsong = false;
  bool lastsong = false;
  int large = 0;

  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((indx) {
      if (indx != null) {
        Getallsongs.currentindexgetallsongs = indx;
        if (mounted) {
          setState(() {
            large = widget.count - indx;
            currentindex = indx;
            indx == 0 ? firstsong = true : firstsong = false;
            indx == large ? lastsong = true : lastsong = false;
          });
        }
      }
    });
    // ignore: todo
    // TODO: implement initState
    super.initState();
    playSong();
  }

  playSong() {
    Getallsongs.audioPlayer.play();
    Getallsongs.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    Getallsongs.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  bool isShuffling = false;

  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 99, 83),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info,
                color: Colors.black,
              ))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                left: screenWidth * .2,
                top: screenHight * 0.04,
                child:
                    ArtworkWidget(widget: widget, curentindex: currentindex)),
            const SizedBox(
              height: 30,
            ),
            Positioned(
              top: screenHight * .42,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Text(
                  widget.songmodel[currentindex].displayNameWOExt,
                  style: GoogleFonts.orbitron(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Positioned(
              top: screenHight * .46,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.songmodel[currentindex].artist.toString() == "unknown"
                      ? "Unknown Aartist"
                      : widget.songmodel[currentindex].artist.toString(),
                  style: GoogleFonts.orbitron(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Positioned(
              top: screenHight * .5,
              left: screenWidth * .03,
              right: screenWidth * .03,
              child: Playcontrollers(
                  count: widget.count,
                  songModel: widget.songmodel[currentindex],
                  firstsong: firstsong,
                  lastsong: lastsong),
            ),
            const SizedBox(
              height: 10,
            ),
            Positioned(
              top: screenHight * .6,
              right: screenWidth * .1,
              left: screenWidth * .1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slider(
                    inactiveColor: const Color.fromARGB(255, 125, 126, 126),
                    activeColor: const Color.fromARGB(255, 48, 41, 40),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changetoseconds(value.toInt());
                        value = value;
                      });
                    }),
              ),
            ),
            Positioned(
              top: screenHight * .65,
              left: screenWidth * .03,
              right: screenWidth * .03,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _position.toString().split(".")[0],
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 173, 169, 169)),
                    ),
                    Text(
                      _duration.toString().split(".")[0],
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 173, 169, 169)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        fixedColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 29, 99, 83),
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 29, 99, 83),
            icon: IconButton(
              onPressed: () {
                if (FavorateDb.isfavorite(widget.songmodel[currentindex])) {
                  FavorateDb.deleteSong(widget.songmodel[currentindex].id);
                  const remove = SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Color.fromARGB(222, 38, 46, 67),
                    content: Center(
                      child: Text(
                        'Song Removed In Favorate List',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70),
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(remove);
                } else {
                  FavorateDb.addSongs(widget.songmodel[currentindex]);
                  const add = SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Color.fromARGB(222, 38, 46, 67),
                    content: Center(
                      child: Text(
                        'Song Added In Favorate List',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70),
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(add);
                }
              },
              icon: Icon(
                  FavorateDb.isfavorite(widget.songmodel[currentindex])
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.black),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 29, 99, 83),
            icon: IconButton(
              onPressed: () {
                showPlaylistdialognow(context, widget.songmodel[currentindex]);
              },
              icon: const Icon(Icons.playlist_add),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 29, 99, 83),
            icon: IconButton(
              onPressed: () {
                setState(() {
                  isShuffling == false
                      ? Getallsongs.audioPlayer.setShuffleModeEnabled(true)
                      : Getallsongs.audioPlayer.setShuffleModeEnabled(false);
                });
              },
              icon: StreamBuilder<bool>(
                stream: Getallsongs.audioPlayer.shuffleModeEnabledStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  isShuffling = snapshot.data ?? false;
                  if (isShuffling) {
                    return const Icon(
                      Icons.shuffle_on_outlined,
                      color: Colors.black,
                      size: 25,
                    );
                  } else {
                    return const Icon(
                      Icons.shuffle_rounded,
                      color: Colors.black,
                      size: 25,
                    );
                  }
                },
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: const Color.fromARGB(255, 29, 99, 83),
            icon: IconButton(
                onPressed: () {
                  setState(() {
                    Getallsongs.audioPlayer.loopMode == LoopMode.one
                        ? Getallsongs.audioPlayer.setLoopMode(LoopMode.all)
                        : Getallsongs.audioPlayer.setLoopMode(LoopMode.one);
                  });
                },
                icon: StreamBuilder<LoopMode>(
                  stream: Getallsongs.audioPlayer.loopModeStream,
                  builder: (context, snapshot) {
                    final loopmode = snapshot.data;
                    if (LoopMode.one == loopmode) {
                      return const Icon(
                        Icons.repeat_on_outlined,
                        color: Colors.black,
                      );
                    } else {
                      return const Icon(Icons.repeat, color: Colors.black);
                    }
                  },
                )),
            label: '',
          ),
        ],
      ),
    );
  }

  void changetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongs.audioPlayer.seek(duration);
  }
}
