import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/controller/get_all_song.dart';
import 'package:musicapp/database/database.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/nowplaying/onplaying.dart';
import 'playlistaddsong.dart';

class SinglePlaylist extends StatelessWidget {
  const SinglePlaylist({
    super.key,
    required this.playlist,
    required this.findex,
    this.photo,
  });
  final MusicWorld playlist;
  final int findex;
  // ignore: prefer_typing_uninitialized_variables
  final photo;

  @override
  Widget build(BuildContext context) {
    late List<SongModel> songPlaylist;
    return ValueListenableBuilder(
      valueListenable: Hive.box<MusicWorld>('playlistDb').listenable(),
      builder: (BuildContext context, Box<MusicWorld> music, Widget? child) {
        songPlaylist = listPlaylist(music.values.toList()[findex].songId);
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
//pop button
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
// Add song
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistAddSong(
                            playlist: playlist,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
          //Title
                  title: Text(
                    playlist.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  expandedTitleScale: 2.5,
                  background: Image.asset(
                    photo,
                    fit: BoxFit.cover,
                  ),
                ),
                backgroundColor: backgroundColor,
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.width * 2.5 / 4,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    songPlaylist.isEmpty
                        ?
                        Center(
                            child: Column(
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlaylistAddSong(
                                            playlist: playlist,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.add_box,
                                      size: 50,
                                      color: white,
                                    )),
                                const Center(
                                    child: Text(
                                  'Add Songs To Your playlist',
                                  style: TextStyle(fontSize: 20,color: white),
                                )),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                           
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                    
                                  /*   boxShadow: [
                                      BoxShadow(
                                          color: Colors.white.withOpacity(1),
                                          spreadRadius: 1,
                                          blurRadius: 8),
                                    ], */
                                  ),
                                  // color:
                                  //     const Color.fromARGB(255, 243, 170, 75),
                                  child: ListTile(
                                    leading: QueryArtworkWidget(
                                      id: songPlaylist[index].id,
                                      type: ArtworkType.AUDIO,
                                      artworkWidth: 50,
                                      artworkHeight: 50,
                                      keepOldArtwork: true,
                                      artworkBorder: BorderRadius.circular(6),
                                      nullArtworkWidget: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color:
                                              white,
                                        ),
                                        height: 50,
                                        width: 50,
                                        child: Icon(
                                          Icons.music_note,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                        songPlaylist[index].displayNameWOExt,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: white
                                        ),
                                        ),
                                    subtitle: Text(
                                      songPlaylist[index].artist.toString(),
                                      maxLines: 1,
                                       style: const TextStyle(
                                          color: white
                                        ),
                                    ),
                                    trailing: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: IconButton(
                                        icon:const Icon(
                                          Icons.remove,
                                          color:
                                             white,
                                        ),
                                        onPressed: () {
                                          songDeleteFromPlaylist(
                                              songPlaylist[index], context);
                                        },
                                      ),
                                    ),
                                    onTap: () {
                                      Getallsong.audioplayer
                                          .setAudioSource(
                                              Getallsong
                                                  .createSongList(songPlaylist),
                                              initialIndex: index);
                                    

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NowPlaying(
                                            songModel: songPlaylist,
                                            count: songPlaylist.length,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: songPlaylist.length,
                          )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void songDeleteFromPlaylist(SongModel data, context) {
    playlist.deleteData(data.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song removed from Playlist',
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < Getallsong.songcopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (Getallsong.songcopy[i].id == data[j]) {
          plsongs.add(Getallsong.songcopy[i]);
        }
      }
    }
    return plsongs;
  }
}
