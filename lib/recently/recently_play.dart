import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/DB/functions/function_recently.dart';
import 'package:project_one_tuneup/NowPlaying/now_playing.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';

class Recentlyplayedlist extends StatefulWidget {
  const Recentlyplayedlist({super.key});

  @override
  State<Recentlyplayedlist> createState() => _RecentlyplayedlistState();
}

class _RecentlyplayedlistState extends State<Recentlyplayedlist> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> recent = [];
  @override
  void initState() {
    initialize();
    // TODO: implement initState
    super.initState();
  }

  initialize() async {
    await Recentfunctions.getallrecently();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Recentfunctions.getallrecently(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: Recentfunctions.recenlylistnotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: Text(
                    "Your Recent Is Empty",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60),
                  ),
                ),
              );
            } else {
              final temp = value.reversed.toList();
              recent = temp.toSet().toList();
              return FutureBuilder(
                future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, items) {
                  if (items.data == null) {
                    const CircularProgressIndicator();
                  } else if (items.data!.isEmpty) {
                    return const Center(
                      child: Text('No songs in your internal'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: recent.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: QueryArtworkWidget(
                        id: recent[index].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: 60,
                        artworkWidth: 60,
                        nullArtworkWidget: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/istockphoto-135437114-170667a.jpg',
                          ),
                          radius: 25,
                        ),
                        artworkBorder: BorderRadius.circular(10),
                        artworkFit: BoxFit.cover,
                      ),
                      title: Text(recent[index].displayNameWOExt,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.white70)),
                      subtitle: Text(
                        '${recent[index].artist}',
                        style: const TextStyle(color: Colors.white70),
                        maxLines: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NowPlayingScreen(
                                    songmodel: Getallsongs.playsong)));
                      },
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
