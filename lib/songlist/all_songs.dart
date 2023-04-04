import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_one_tuneup/DB/functions/function_fav.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';
import 'package:project_one_tuneup/songlist/all_songs_list.dart';

List<SongModel> startsong = [];

class AllSonglist extends StatefulWidget {
  const AllSonglist({super.key});

  @override
  State<AllSonglist> createState() => _AllSonglistState();
}

class _AllSonglistState extends State<AllSonglist> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    bool status = await audioQuery.permissionsStatus();
    if (!status) {
      await audioQuery.permissionsRequest();
    }
    setState(() {});
    Permission.storage.request();
  }

  final audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return Center(
            child: Text(
              'No Songs Found',
              style: GoogleFonts.orbitron(
                fontSize: 15,
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w300,
              ),
            ),
          );
        }
        if (audioPlayer.audioSource == null) {
          audioPlayer.setAudioSource(Getallsongs.createsongslist(item.data!));
        }
        startsong = item.data!;

        FavorateDb.initialized(item.data!);

        return AllMusiclist(songmodel: item.data!);
      },
    );
  }
}
