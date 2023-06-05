import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/database.dart';

class PlaylistAddSong extends StatefulWidget {
  const PlaylistAddSong({super.key, required this.playlist});
  final MusicWorld playlist;
  @override
  State<PlaylistAddSong> createState() => _PlaylistAddSongState();
}

class _PlaylistAddSongState extends State<PlaylistAddSong> {
  bool isPlaying = true;
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Add songs"),
        backgroundColor: backgroundColor,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('No songs availble'),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  // color: const Color.fromARGB(255, 248, 247, 247),
                  child: ListTile(
                    leading: QueryArtworkWidget(
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: 50,
                      artworkHeight: 50,
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(6),
                      nullArtworkWidget: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: white,
                        ),
                        height: 50,
                        width: 50,
                        child:
                            const Icon(Icons.music_note, color: Colors.black),
                      ),
                    ),
                    title: Text(
                      item.data![index].displayNameWOExt,
                      maxLines: 1,
                      style: const TextStyle(color: white),
                    ),
                    subtitle: Text(
                      item.data![index].artist.toString(),
                      maxLines: 1,
                      style: const TextStyle(color: white),
                    ),
                    trailing: SizedBox(
                      height: 60,
                      width: 60,
                      child: Container(
                        child: !widget.playlist.isValueIn(item.data![index].id)
                            ? IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      songAddToPlaylist(
                                        item.data![index],context
                                      );
                                      
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: white,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      songDeleteFromPlaylist(item.data![index],context);
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }

  void songAddToPlaylist(SongModel data, context ) {
    widget.playlist.playlistadd(data.id);
    final addedToPlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song added to playlist',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 650),
    );
    ScaffoldMessenger.of(context).showSnackBar(addedToPlaylist);
  }

  void songDeleteFromPlaylist(SongModel data,context) {
    widget.playlist.deleteData(data.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song removed from Playlist',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }
}
