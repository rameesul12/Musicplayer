import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/home.dart';


class MostlyPlayed extends ChangeNotifier {
  static ValueNotifier<List<SongModel>> mostlyPlayedSongNotifier =
      ValueNotifier([]);
  static List<dynamic> mostlyPlayed = [];
    static List<dynamic> count = [];

  static Future<void> addmostlyPlayed(item) async {
    final mostlyplaydDb = await Hive.openBox('mostlyPlayedDb');
    await mostlyplaydDb.add(item); 
    getMostlyPlayed();
    addcount(item);
  
  }
static void addcount(value){  
count.add(value);

}
  static Future<void> getMostlyPlayed() async {
    final mostlyPlayedDb = await Hive.openBox('mostlyPlayedDb');
    mostlyPlayed = mostlyPlayedDb.values.toList();
    
    displayMostlyPlayed();
    mostlyPlayedSongNotifier.notifyListeners();
  }

 
static Future<List> displayMostlyPlayed()async {
/*     final mostlyPlayedDb = await Hive.openBox('mostlyPlayedDb');
    final mostlyPlayedItems = mostlyPlayedDb.values.toList();
    mostlyPlayedSongNotifier.value.clear();
    int counts = 0;
    for (var i = 0; i < mostlyPlayedItems.length; i++) {
      for (var j = 0; j < startsong.length; j++) {
        if (mostlyPlayedItems[i] == startsong[j].id) {
          counts++;
        }
      }

      if (counts > 3) {
       
        for (var k = 0; k < startsong.length; k++) {
          if (mostlyPlayedItems[i] == startsong[k].id) {
            mostlyPlayedSongNotifier.value.add(startsong[k]);
            mostlyPlayed.add(startsong[k]);
          }
        }
        counts = 0;
      }
    }
    return mostlyPlayed;
} */

    final mostlyPlayedDb = await Hive.openBox('mostlyPlayedDb'); 
    var count=mostlyPlayedDb.values.toList();
    mostlyPlayedSongNotifier.value.clear();
    mostlyPlayed.clear();
    
for (var i = 0; i < count.length-1; i++) {
  int counts=0;
  for (var j = 0; j < count.length; j++) {
    if (count[i]==count[j]&&i!=j) {     
      counts++;     
    }
  
    if (counts>3) {
      for (var k = 0; k < startsong.length; k++) {
        if (count[i]==startsong[k].id) {
          mostlyPlayedSongNotifier.value.add(startsong[k]);
          mostlyPlayed.add(startsong[k]);
        }
      }
        counts=0; 
      } 
     
    }
    
  }
  return mostlyPlayed;
}
mostlyplayedsamplelogic(item){

}


  }

  

