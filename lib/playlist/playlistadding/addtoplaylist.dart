import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/playlist/playlist.dart';
import 'package:musicapp/provider/playlistProvider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';

dialoguePlaylist(BuildContext context, SongModel songModel) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: white,
          title: const Text(
            'Select a Playlist',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          content: SizedBox(
            height: 150,
            width: double.maxFinite,
            child: Consumer<PlaylistProvider>(
                // valueListenable:
                //     Hive.box<MusicWorld>('playlistDb').listenable(),
                builder: (context, musicList, child) {
                  return Hive.box<MusicWorld>('playlistDb').isEmpty
                      ? const Center(
                          child: Text(
                          'No Playlist found',
                          style: TextStyle(fontSize: 18,color: Colors.black),
                        ))
                      : ListView.builder(
                          itemCount: musicList.playlistNotifier.length,
                          itemBuilder: (context, index) {
                            final data = musicList.playlistNotifier.toList()[index];
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(data.name),
                                trailing: const Icon(Icons.playlist_add,
                                    color: Colors.black),
                                onTap: () {
                                  addSongToPlaylist(
                                      context, songModel, data, data.name);
                                },
                              ),
                            );
                          });
                }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                nameController.clear();
                Navigator.pop(context);
                newplaylist(context, formKey);
              },
              child: const Text('New Playlist'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
}

void addSongToPlaylist(
    BuildContext context, SongModel data, datas, String name) {
  if (!datas.isValueIn(data.id)) {
    datas.playlistadd(data.id);
    final songAddSnackBar = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
       // behavior: SnackBarBehavior.fixed,
        content: Text(
          "Song Added To $name",
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAddSnackBar);
    Navigator.pop(context);
  } else {
    final songAlreadyExist = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
       // behavior: SnackBarBehavior.fixed,
        content: Text(
          "Song Already exist In $name",
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAlreadyExist);
    Navigator.pop(context);
  }
}
