import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavorateDb {
  static bool isinitialized = false;
  static final songdatabase = Hive.box<int>('favoriteDb');
  static ValueNotifier<List<SongModel>> favoritesongs = ValueNotifier([]);

  static initialized(List<SongModel> allsong) {
    favoritesongs.value.clear();
    for (SongModel song in allsong) {
      if (isfavorite(song)) {
        favoritesongs.value.add(song);
      }
    }
    isinitialized = true;
  }

  static isfavorite(SongModel song) {
    if (songdatabase.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static addSongs(SongModel song) async {
    songdatabase.add(song.id);
    favoritesongs.value.add(song);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    FavorateDb.favoritesongs.notifyListeners();
  }

  static deleteSong(int id) async {
    int delete = 0;
    if (!songdatabase.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> map = songdatabase.toMap();
    map.forEach((key, value) {
      if (value == id) {
        delete = key;
      }
    });
    songdatabase.delete(delete);
    favoritesongs.value.removeWhere((song) => song.id == id);
  }

  static clear() async {
    FavorateDb.favoritesongs.value.clear();
  }
}
