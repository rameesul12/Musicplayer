import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../database.dart';

class PlaylistDb extends ChangeNotifier {
  static ValueNotifier<List<MusicWorld>> playlistNotifier = ValueNotifier([]);
  static final playlistDb = Hive.box<MusicWorld>('playlistDb');

  static Future<void> addPlaylist(MusicWorld value) async {
    final playlistDb = Hive.box<MusicWorld>('playlistDb');
    await playlistDb.add(value);
    playlistNotifier.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<MusicWorld>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
  }


  static Future<void> editPlaylist(int index, MusicWorld value) async {
    final playlistDb = Hive.box<MusicWorld>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
  }

}