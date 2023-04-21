import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/Librery/librery.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';
import 'package:project_one_tuneup/recently/recently.dart';
import 'package:project_one_tuneup/settings/settings.dart';
import 'package:project_one_tuneup/songlist/all_songs.dart';
import 'package:project_one_tuneup/widgets/play_list_scroll.dart';

import 'package:project_one_tuneup/search/search.dart';
import 'package:flutter/src/rendering/box.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  int indx = 0;
  List<Widget> widgetsong = [AllSonglist()];
  OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
        title: Text(
          'TuneUp',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Searchwidget(),
                    ));
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      body: Column(
        children: [
          // const SearchSong(),
          Stack(children: [
            Positioned(
              top: screenHight / 50,
              left: screenWidth / 30,
              child: Text(
                'Librery',
                style: GoogleFonts.orbitron(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LibreryPage()));
                      },
                      child: Text(
                        '',
                        style: GoogleFonts.orbitron(
                          color: Colors.grey,
                        ),
                      ))),
            ),
          ]),
          const ScrollPlay(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Text(
              'All Songs',
              style: GoogleFonts.orbitron(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Expanded(
            child: widgetsong[indx],
          ),
        ],
      ),
    );
  }
}
