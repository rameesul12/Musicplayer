import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/widgets/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Recentlysong extends ChangeNotifier{

static ValueNotifier<List<SongModel>>recentnotifier=ValueNotifier([]);
static List<dynamic> recentlyPlayed=[];

static Future<void> addrecentlyplayed (songid) async{
final recentDb=await Hive.openBox('recentlyDb');

await recentDb.add(songid);
getrecentsong();
recentnotifier.notifyListeners();
}

static Future <void>getrecentsong()async{
  final recentDb=await Hive.openBox('recentlyDb');
 recentlyPlayed= recentDb.values.toList();
 displayRecent();
 recentnotifier.notifyListeners();
}

static Future<void>displayRecent()async{
  final recentDb=await Hive.openBox('recentlyDB');
  final recentSongitem=recentDb.values.toList();

  recentnotifier.value.clear();
  recentlyPlayed.clear();
  for (var i = 0; i < recentSongitem.length; i++) {
    for (var j = 0; j < startsong.length; j++) {
      if (recentSongitem[i]==startsong[j].id) {
        recentnotifier.value.add(startsong[j]);
        recentlyPlayed.add(startsong[j]);
      }
  
    }
    
  }
}


}