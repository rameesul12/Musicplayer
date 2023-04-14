import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/controller/get_all_song.dart';
import 'package:musicapp/playlist/playlistadding/addtoplaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../database/favoritedb.dart';

class PlayingControls extends StatefulWidget {
  const PlayingControls({
    super.key,
    required this.count,
    required this.favSongModel,
    required this.lastSong,
    required this.firstSong,
  });

  final int count;
  final bool firstSong;
  final bool lastSong;
  final SongModel favSongModel;
  @override
  State<PlayingControls> createState() => _PlayingControlsState();
}

class _PlayingControlsState extends State<PlayingControls> {
  bool isPlaying = true;
  bool isShuffling = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ValueListenableBuilder(
              valueListenable: FavoriteDb.favoriteSongs,
              builder: (context, List<SongModel> favoritedata, child) {
                return IconButton(
                    onPressed: () {
                      if (FavoriteDb.isFavor(widget.favSongModel)) {
                        FavoriteDb.delete(widget.favSongModel.id);
                        const remove = SnackBar(
                          content: Text('Song removed from favorites'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(remove);
                      } else {
                        FavoriteDb.add(widget.favSongModel);
                        const addFav = SnackBar(
                          content: Text('Song added to favorites'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(addFav);
                      }
                      FavoriteDb.favoriteSongs.notifyListeners();
                    },
                    icon: FavoriteDb.isFavor(widget.favSongModel)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ));
              },
            ),
            IconButton(
                onPressed: () {
                                                            dialoguePlaylist(context,
                                                widget.favSongModel);
                },
                icon: const Icon(
                  Icons.playlist_add,
                  size: 30,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 15,
            ),
            //shuffle
            IconButton(
              onPressed: () {
               isShuffling == false
                          ? Getallsong.audioplayer
                              .setShuffleModeEnabled(true)
                          : Getallsong.audioplayer
                              .setShuffleModeEnabled(false);
              },
              icon: StreamBuilder<bool>(
                      stream:
                          Getallsong.audioplayer.shuffleModeEnabledStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          isShuffling = snapshot.data;
                        }
                        if (isShuffling) {
                          return const Icon(
                            Icons.shuffle,
                            size: 30,
                            color: Colors.red,
                          );
                        } else {
                          return const Icon(
                            Icons.shuffle,
                            color: Colors.white,
                          );
                        }
                      },
                    ),
                  ),

            
            //repeat
            IconButton(
              onPressed: () {
               Getallsong.audioplayer.loopMode == LoopMode.one
                          ? Getallsong.audioplayer.setLoopMode(LoopMode.all)
                          : Getallsong.audioplayer
                              .setLoopMode(LoopMode.one);
              },
              icon: StreamBuilder<LoopMode>(
                      stream: Getallsong.audioplayer.loopModeStream,
                      builder: (context, snapshot) {
                        final loopMode = snapshot.data;
                        if (LoopMode.one == loopMode) {
                          return const Icon(
                            Icons.repeat,
                            size: 30,
                            color: Colors.red,
                          );
                        } else {
                          return const Icon(
                            Icons.repeat,
                            color: white,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
    // skip previous
            widget.firstSong
                ? Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.skip_previous,
                          color: Colors.white30,
                          size: 60,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (Getallsong.audioplayer.hasPrevious) {
                            Getallsong.audioplayer.seekToPrevious();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Color.fromARGB(255, 250, 249, 249),
                          size: 60,
                        ),
                      ),
                    ),
                  ),
    // play pause
            Center(
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          if (Getallsong.audioplayer.playing) {
                            Getallsong.audioplayer.pause();
                          } else {
                            Getallsong.audioplayer.play();
                          }
                          isPlaying = !isPlaying;
                        });
                      }
                    },
                    icon: isPlaying
                        ? const Icon(
                            Icons.pause,
                            color: Color.fromARGB(255, 5, 4, 4),
                            size: 50,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 50,
                          )),
              ),
            ),
    // skip next
            widget.lastSong
                ? Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (Getallsong.audioplayer.hasNext) {
                            Getallsong.audioplayer.seekToNext();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  )
          ],
        )
      ],
    );
  }
}
