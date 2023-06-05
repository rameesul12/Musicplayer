import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/database/database.dart';
import 'package:musicapp/provider/favoriteProvider.dart';
import 'package:musicapp/provider/mostlyPlayed.dart';
import 'package:provider/provider.dart';


 resetfunction(BuildContext context){
final PlaylistDb=Hive.box<MusicWorld>('playlistDb');
final recentDb=Hive.box('recentlyDb');
final mostlyPlayedDb=Hive.box('mostlyPlayedDb');
final musicDb=Hive.box<int>('FavoriteDB');
 PlaylistDb.clear();
 musicDb.clear();
mostlyPlayedDb.clear();
recentDb.clear();
Provider.of<MostlyPlayedProvider>(context).mostlyPlayedSong.clear();
Provider.of<FavoriteProvider>(context).favoriteSongs.clear();
// FavoriteDb.favoriteSongs.value.clear();
// //Recentlysong.recentnotifier.value.clear();
// MostlyPlayed.mostlyPlayedSongNotifier.value.clear();
 

}