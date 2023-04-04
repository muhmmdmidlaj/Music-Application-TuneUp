import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/songlist/all_songs_list.dart';

class Searchwidget extends StatefulWidget {
  const Searchwidget({super.key});

  @override
  State<Searchwidget> createState() => _SearchwidgetState();
}

List<SongModel> totalsongs = [];
List<SongModel> stillsongs = [];
final OnAudioQuery audioQuery = OnAudioQuery();
final FocusScopeNode _node = FocusScopeNode();

class _SearchwidgetState extends State<Searchwidget> {
  @override
  void initState() {
    fetchallsongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            )),
        title: TextField(
          onChanged: (value) => update(value),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 5, 12, 25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search ',
            hintStyle: GoogleFonts.orbitron(
              color: Colors.grey,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
        elevation: 15,
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      ),
      body: stillsongs.isEmpty
          ? Center(
              child: Text(
                'No Songs ',
                style: GoogleFonts.orbitron(
                  color: Colors.grey,
                  fontSize: 25,
                ),
              ),
            )
          : AllMusiclist(
              songmodel: stillsongs,
            ),
    );
  }

  update(String text) {
    List<SongModel> result = [];
    if (text.isEmpty) {
      result = totalsongs;
    } else {
      result = totalsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
    setState(() {
      stillsongs = result;
    });
  }

  Future<void> fetchallsongs() async {
    totalsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }
}
