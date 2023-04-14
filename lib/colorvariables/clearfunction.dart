import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/database/database.dart';
import 'package:musicapp/database/recentlyDb.dart';

import '../database/favoritedb.dart';
import '../mostlyplayed/mostlydb.dart';


 resetfunction(){
final PlaylistDb=Hive.box<MusicWorld>('playlistDb');
final recentDb=Hive.box('recentlyDb');
final mostlyPlayedDb=Hive.box('mostlyPlayedDb');
final musicDb=Hive.box<int>('FavoriteDB');
 PlaylistDb.clear();
 musicDb.clear();
mostlyPlayedDb.clear();
recentDb.clear();

 FavoriteDb.favoriteSongs.value.clear();
Recentlysong.recentnotifier.value.clear();
MostlyPlayed.mostlyPlayedSongNotifier.value.clear();
 

}