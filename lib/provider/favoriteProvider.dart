import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteProvider with ChangeNotifier {

  bool isInitialized = false;
 final musicDb=Hive.box<int>('FavoriteDB');
  List<SongModel> favoriteSongs = [];
 //bool isfav=false;
   initialize(List<SongModel> favSongs) {

    for (SongModel song in favSongs) {
      if (isFavor(song)) {
        favoriteSongs.add(song);
      }
    }
    isInitialized = true;
  }

  isFavor(SongModel song) {
   // final musicDb = Hive.box<int>('favoriteDb');
    if (musicDb.values.contains(song.id)) {
  //    notifyListeners();
      return true;
    }
    return false;
  }

  void add(SongModel song) {
  //  final musicDb = Hive.box<int>('favoriteDb');
  musicDb.put(song.id, song.id);
    // musicDb.add(song.id);
    favoriteSongs.add(song);
   //isfav=true;
    notifyListeners();
  }

  void delete(int id) {
   // final musicDb = Hive.box<int>('favoriteDb');
    int deleteKey = 0;
    if (!musicDb.values.contains(id)) {
      
      return;
    }
    final Map<dynamic, int> favorMap = musicDb.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deleteKey = id;
      }
    });
    musicDb.delete(deleteKey);
   
  //  isfav=false;
    favoriteSongs.removeWhere((song) => song.id == id);
    notifyListeners();
    
  }
  clearFunction(){
    final musicDb=Hive.box<int>('favoriteDb');
    musicDb.clear();
    notifyListeners();
  }
}

