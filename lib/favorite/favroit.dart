import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/DB/functions/function_fav.dart';
import 'package:project_one_tuneup/search/search.dart';
import 'package:project_one_tuneup/songlist/all_songs_list.dart';

class FavroiteScreen extends StatefulWidget {
  const FavroiteScreen({super.key});

  @override
  State<FavroiteScreen> createState() => _FavroiteScreenState();
}

class _FavroiteScreenState extends State<FavroiteScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: FavorateDb.favoritesongs,
      builder: (context, List<SongModel> favoritedata, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 5, 12, 25),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 5, 12, 25),
            elevation: 15,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white60,
                )),
            title: Text(
              'Favourites',
              style: GoogleFonts.orbitron(
                fontSize: 22,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white60,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Searchwidget(),
                      ));
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: screenHight,
                  child: ValueListenableBuilder(
                    valueListenable: FavorateDb.favoritesongs,
                    builder: (context, List<SongModel> value, Widget? child) {
                      if (value.isEmpty) {
                        return Center(
                          child: Text(
                            'No songs in favourites',
                            style: GoogleFonts.orbitron(
                                fontSize: 22, color: Colors.grey),
                          ),
                        );
                      } else {
                        final temp = value.reversed.toList();
                        value = temp.toSet().toList();
                        return AllMusiclist(
                          songmodel: value,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
