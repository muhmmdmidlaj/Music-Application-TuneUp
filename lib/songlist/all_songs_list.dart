import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/DB/functions/function_fav.dart';
import 'package:project_one_tuneup/DB/functions/function_mostly.dart';
import 'package:project_one_tuneup/DB/functions/function_recently.dart';
import 'package:project_one_tuneup/NowPlaying/now_playing.dart';
import 'package:project_one_tuneup/controller/getallsongs_controller.dart';
import 'package:project_one_tuneup/model/model.dart';
import 'package:project_one_tuneup/playlist/play_list.dart';
import 'package:project_one_tuneup/provider/provider.dart';
import 'package:project_one_tuneup/songlist/all_songs.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AllMusiclist extends StatefulWidget {
  AllMusiclist({super.key, required this.songmodel});
  List<SongModel> songmodel = [];
  @override
  State<AllMusiclist> createState() => _AllMusiclistState();
}

class _AllMusiclistState extends State<AllMusiclist> {
  List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        songs.addAll(widget.songmodel);
        return SizedBox(
          height: 65,
          child: ListTile(
            leading: QueryArtworkWidget(
              id: widget.songmodel[index].id,
              type: ArtworkType.AUDIO,
              artworkHeight: 60,
              artworkWidth: 60,
              nullArtworkWidget: CircleAvatar(
                radius: 25,
                child: Lottie.asset(
                    'assets/animations/69359-listening-music.json'),
              ),
              artworkBorder: BorderRadius.circular(10),
              artworkFit: BoxFit.cover,
            ),
            title: Text(widget.songmodel[index].displayNameWOExt,
                maxLines: 1, style: const TextStyle(color: Colors.white70)),
            subtitle: Text(
              '${widget.songmodel[index].artist}',
              style: const TextStyle(color: Colors.white70),
              maxLines: 1,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white70,
                    context: context,
                    builder: (ctx) {
                      return SizedBox(
                        height: 230,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.playlist_add,
                                  color: Colors.black),
                              title: const Text(
                                'Add playlist',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 39, 33, 55),
                                ),
                              ),
                              onTap: () {
                                showPlaylistdialog(context, startsong[index]);
                              },
                            ),
                            ValueListenableBuilder(
                                valueListenable: FavorateDb.favoritesongs,
                                builder:
                                    (context, List<SongModel> data, child) {
                                  return ListTile(
                                    title: Text(
                                      FavorateDb.isfavorite(
                                              widget.songmodel[index])
                                          ? 'Remove Favorites'
                                          : 'Add Favorites',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 39, 33, 55),
                                      ),
                                    ),
                                    onTap: () {
                                      if (FavorateDb.isfavorite(
                                          widget.songmodel[index])) {
                                        FavorateDb.deleteSong(
                                            widget.songmodel[index].id);
                                        const remove = SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(222, 38, 46, 67),
                                          content: Center(
                                            child: Text(
                                              ' Removed In Favorate List',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white70),
                                            ),
                                          ),
                                          duration: Duration(seconds: 3),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(remove);
                                      } else {
                                        FavorateDb.addSongs(
                                            widget.songmodel[index]);
                                        const add = SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(222, 38, 46, 67),
                                          content: Center(
                                              child: Center(
                                            child: Text(
                                              'Song Added In Favorate List',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white70),
                                            ),
                                          )),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(add);
                                      }
                                      FavorateDb.favoritesongs
                                          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                          .notifyListeners();

                                      Navigator.pop(context);
                                    },
                                    leading: FavorateDb.isfavorite(
                                            widget.songmodel[index])
                                        ? const Icon(Icons.favorite,
                                            color:
                                                Color.fromARGB(255, 39, 33, 55))
                                        : const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Color.fromARGB(
                                                255, 39, 33, 55)),
                                  );
                                }),
                            ListTile(
                              leading:
                                  const Icon(Icons.info, color: Colors.black),
                              title: const Text(
                                'Song Info',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 39, 33, 55),
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            onTap: () {
              FocusScope.of(context).unfocus();
              MostlyplayedDb.addmostlyplayed(widget.songmodel[index].id);
              Recentfunctions.addrecentlyplayed(widget.songmodel[index].id);
              Getallsongs.audioPlayer.setAudioSource(
                  Getallsongs.createsongslist(widget.songmodel),
                  initialIndex: index);

              context.read<Songprovider>().setid(widget.songmodel[index].id);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NowPlayingScreen(songmodel: widget.songmodel),
                  ));
            },
          ),
        );
      },
      itemCount: widget.songmodel.length,
      controller: ScrollController(keepScrollOffset: true),
    );
  }
}

showPlaylistdialog(BuildContext context, SongModel songModel) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 5, 12, 25),
          title: const Text(
            "choose your playlist",
            style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ValueListenableBuilder(
                valueListenable: Hive.box<PlayModel>('playlistDB').listenable(),
                builder: (BuildContext context, Box<PlayModel> musicList,
                    Widget? child) {
                  return Hive.box<PlayModel>('playlistDB').isEmpty
                      ? Center(
                          child: Stack(
                            children: const [
                              Positioned(
                                right: 30,
                                left: 30,
                                bottom: 50,
                                child: Center(
                                  child: Text('No Playlist found!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: musicList.length,
                          itemBuilder: (ctx, index) {
                            final data = musicList.values.toList()[index];

                            return Card(
                              color: const Color.fromARGB(255, 8, 120, 175),
                              shadowColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.white)),
                              child: ListTile(
                                title: Text(
                                  data.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'poppins'),
                                ),
                                trailing: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  songaddtoplaylist(
                                      songModel, data, data.name, ctx);
                                  Navigator.pop(ctx);
                                },
                              ),
                            );
                          },
                        );
                }),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  newplaylist(context, formkey);
                },
                child: Text(
                  'New Playlist',
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                  ),
                ))
          ],
        );
      });
}

void songaddtoplaylist(
    SongModel data, datas, String name, BuildContext context) {
  if (!datas.isvalule(data.id)) {
    datas.add(data.id);
    final snake1 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(222, 38, 46, 67),
        content: Center(
            child: Text(
          'Playlist Add To $name',
          style: const TextStyle(color: Colors.white60),
        )));
    ScaffoldMessenger.of(context).showSnackBar(snake1);
  } else {
    final snake2 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Center(child: Text('Song Alredy Added In $name')));
    ScaffoldMessenger.of(context).showSnackBar(snake2);
  }
}

Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: namecontroller,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: GoogleFonts.orbitron(color: Colors.white),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: GoogleFonts.orbitron(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                namecontroller.clear();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.orbitron(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  saveButtonPressed(context);
                }
              },
              child: Text(
                'Create',
                style: GoogleFonts.orbitron(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
