import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_one_tuneup/model/model.dart';

class PlayListDatabase {
  static ValueNotifier<List<PlayModel>> playlistnotifire = ValueNotifier([]);
  static final playlistdata = Hive.box<PlayModel>('playlistDB');

  static Future<void> addplaylist(PlayModel value) async {
    final playlistdata = Hive.box<PlayModel>('playlistDB');
    await playlistdata.add(value);
    playlistnotifire.value.add(value);
  }

  static Future<void> getallplaylist() async {
    final playlistdata = Hive.box<PlayModel>('playlistDB');
    playlistnotifire.value.clear();
    playlistnotifire.value.addAll(playlistdata.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    playlistnotifire.notifyListeners();
  }

  static Future<void> playlistdelete(int index) async {
    final playlistdata = Hive.box<PlayModel>('playlistDB');
    playlistdata.deleteAt(index);
    getallplaylist();
  }

  static Future<void> playlistedit(PlayModel value, int index) async {
    final playlistdata = Hive.box<PlayModel>('playlistDB');
    playlistdata.putAt(index, value);
    getallplaylist();
  }
}
