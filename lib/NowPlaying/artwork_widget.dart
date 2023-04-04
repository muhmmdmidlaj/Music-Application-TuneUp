import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/NowPlaying/now_playing.dart';

// ignore: must_be_immutable
class ArtworkWidget extends StatelessWidget {
  ArtworkWidget({super.key, required this.widget, required this.curentindex});

  final NowPlayingScreen widget;
  int curentindex;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      keepOldArtwork: true,
      id: widget.songmodel[curentindex].id,
      type: ArtworkType.AUDIO,
      artworkWidth: 250,
      artworkBorder: BorderRadius.circular(300),
      artworkHeight: 250,
      artworkFit: BoxFit.cover,
      nullArtworkWidget: const CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage('assets/images/Music.jpg'),
      ),
    );
  }
}
