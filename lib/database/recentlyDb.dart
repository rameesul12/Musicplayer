import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/widgets/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyProvider extends ChangeNotifier{

List<SongModel>recentList=[];
static List<dynamic> recentlyPlayed=[];

 Future<void> addrecentlyplayed (songid) async{
final recentDb=await Hive.openBox('recentlyDb');

await recentDb.add(songid);
//displayRecent();
await getrecentsong();
notifyListeners();

}

 Future <void>getrecentsong()async{
  final recentDb=await Hive.openBox('recentlyDb');
 recentlyPlayed= recentDb.values.toList();
await displayRecent();
notifyListeners();
}

 Future<void>displayRecent() async{
  final recentDb=await Hive.openBox('recentlyDB');
  final recentSongitem=recentDb.values.toList();

  recentList.clear();
  recentlyPlayed.clear();
  for (var i = 0; i < recentSongitem.length; i++) {
    for (var j = 0; j < startsong.length; j++) {
      if (recentSongitem[i]==startsong[j].id) {
        recentList.add(startsong[j]);
        recentlyPlayed.add(startsong[j]);
      }
  
    }
    
  }
}

 recent() async {
   await getrecentsong();
   }

}