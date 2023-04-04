import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/songlist/all_songs.dart';

class MostlyplayedDb {
  static ValueNotifier<List<SongModel>> mostlyplayednotifier =
      ValueNotifier([]);
  static List<SongModel> mostlyplayed = [];

  static Future<void> addmostlyplayed(item) async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    mostlyDB.add(item);
    getmostlyplayed();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    mostlyplayednotifier.notifyListeners();
  }

  static Future<void> getmostlyplayed() async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    mostlyDB.values.toList();

    displaymostly();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    mostlyplayednotifier.notifyListeners();
  }

  static Future displaymostly() async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    final mostlyplayeditem = mostlyDB.values.toList();

    mostlyplayednotifier.value.clear();
    int value = 0;
    for (var i = 0; i < mostlyplayeditem.length; i++) {
      for (var j = 0; j < mostlyplayeditem.length; j++) {
        if (mostlyplayeditem[i] == mostlyplayeditem[j]) {
          value++;
        }
      }
      if (value > 5) {
        for (var m = 0; m < startsong.length; m++) {
          if (mostlyplayeditem[i] == startsong[m].id) {
            mostlyplayednotifier.value.add(startsong[m]);
            mostlyplayed.add(startsong[m]);
          }
        }
        value = 0;
      }
    }
    return mostlyplayed;
  }
}
