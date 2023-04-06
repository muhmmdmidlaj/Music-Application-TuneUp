import 'package:flutter/material.dart';
import 'package:project_one_tuneup/NowPlaying/now_playing.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';
import 'package:text_scroll/text_scroll.dart';

class Miniplayers extends StatefulWidget {
  const Miniplayers({super.key});

  @override
  State<Miniplayers> createState() => _MiniplayersState();
}

bool firstsong = false;
bool isplaying = true;

class _MiniplayersState extends State<Miniplayers> {
  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((index) {
      if (index == null && mounted) {
        setState(() {
          index == 0 ? firstsong = true : firstsong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return NowPlayingScreen(
              songmodel: Getallsongs.playsong,
            );
          },
        ));
      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * .03),
          child: Container(
            height: screenHight * 0.065,
            width: screenWidth * 0.9,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 10, 197, 138),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        child: StreamBuilder<bool>(
                            stream: Getallsongs.audioPlayer.playingStream,
                            builder: (context, snapshot) {
                              bool? playingstage = snapshot.data;
                              if (playingstage != null && playingstage) {
                                return TextScroll(
                                  Getallsongs
                                      .playsong[
                                          Getallsongs.audioPlayer.currentIndex!]
                                      .displayNameWOExt,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(251, 70, 48, 48)),
                                );
                              } else {
                                return Text(
                                  Getallsongs
                                      .playsong[
                                          Getallsongs.audioPlayer.currentIndex!]
                                      .displayNameWOExt,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Color.fromARGB(251, 70, 48, 48)),
                                );
                              }
                            }),
                      ),
                      firstsong
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white54,
                              ))
                          : IconButton(
                              onPressed: () {
                                if (Getallsongs.audioPlayer.hasPrevious) {
                                  setState(() {
                                    Getallsongs.audioPlayer.seekToPrevious();
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white54,
                              )),
                      // CircleAvatar(
                      //   backgroundColor:
                      //       const Color.fromARGB(255, 99, 211, 245),
                      //   child: IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           isplaying = !isplaying;
                      //         });
                      //         if (Getallsongs.audioPlayer.playing) {
                      //           Getallsongs.audioPlayer.pause();
                      //           setState(() {});
                      //         } else {
                      //           Getallsongs.audioPlayer.play();
                      //           setState(() {});
                      //         }
                      //       },
                      //       icon: Icon(
                      //         isplaying ? Icons.play_arrow : Icons.pause,
                      //         color: const Color.fromARGB(194, 210, 9, 9),
                      //       )),
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: const CircleBorder()),
                        onPressed: () async {
                          setState(() {});
                          if (Getallsongs.audioPlayer.playing) {
                            await Getallsongs.audioPlayer.pause();
                            setState(() {});
                          } else {
                            await Getallsongs.audioPlayer.play();
                            setState(() {});
                          }
                        },
                        child: StreamBuilder<bool>(
                          stream: Getallsongs.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingStage = snapshot.data;
                            if (playingStage != null && playingStage) {
                              return const Icon(
                                Icons.pause_circle,
                                color: Color.fromARGB(255, 219, 219, 219),
                                size: 35,
                              );
                            } else {
                              return const Icon(
                                Icons.play_circle,
                                color: Color.fromARGB(255, 219, 219, 219),
                                size: 35,
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (Getallsongs.audioPlayer.hasNext) {
                              setState(() {
                                Getallsongs.audioPlayer.seekToNext();
                              });
                            }
                          },
                          icon: const Icon(Icons.skip_next,
                              color: Colors.white54))
                    ],
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
