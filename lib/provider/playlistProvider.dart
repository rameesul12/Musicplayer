import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../database/database.dart';

class PlaylistProvider extends ChangeNotifier {
 List<MusicWorld> playlistNotifier = [];
   final playlistDb = Hive.box<MusicWorld>('playlistDb');

   Future<void> addPlaylist(MusicWorld value) async {
    final playlistDb = Hive.box<MusicWorld>('playlistDb');
    await playlistDb.add(value);
    playlistNotifier.add(value);
    notifyListeners();
  }

   Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<MusicWorld>('playlistDb');
    playlistNotifier.clear();
    playlistNotifier.addAll(playlistDb.values);
    notifyListeners();
  }


   Future<void> editPlaylist(int index, MusicWorld value) async {
    final playlistDb = Hive.box<MusicWorld>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
  }

}