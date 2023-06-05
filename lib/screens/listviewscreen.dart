import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/controller/get_all_song.dart';
import 'package:musicapp/database/recentlyDb.dart';
import 'package:musicapp/playlist/playlistadding/addtoplaylist.dart';
import 'package:musicapp/provider/favoriteProvider.dart';
import 'package:musicapp/provider/mostlyPlayed.dart';
import 'package:musicapp/widgets/nowplaying/onplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ListViewScreen extends StatelessWidget {
  ListViewScreen({
    super.key,
    required this.songModel,
    this.recentlength,
    this.isRecent = false,
    this.isMostly = false,
  });
  final List<SongModel> songModel;
  final dynamic recentlength;
  final bool isRecent;
  final bool isMostly;

  List<SongModel> allSongs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: isRecent ? recentlength : songModel.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        allSongs.addAll(songModel);
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Container(
                color: white,
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.white.withOpacity(1),
                //       spreadRadius: 1,
                //       ),
                // ],

                child: Container(
                  color: backgroundColor,
                  child: ListTile(
                      leading: QueryArtworkWidget(
                        id: songModel[index].id,
                        type: ArtworkType.AUDIO,
                        artworkWidth: 50,
                        artworkHeight: 50,
                        keepOldArtwork: true,
                        artworkBorder: BorderRadius.circular(6),
                        nullArtworkWidget: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white12,
                          ),
                          height: 50,
                          width: 50,
                          child: const Icon(
                            Icons.music_note,
                            color: white,
                          ),
                        ),
                      ),
                      title: Text(
                        songModel[index].displayNameWOExt,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        songModel[index].artist.toString(),
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const Icon(
                                                Icons.playlist_add,
                                                size: 30,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  dialoguePlaylist(context,
                                                      songModel[index]);
                                                },
                                                child: const Text(
                                                  " Add to playlist",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Consumer<FavoriteProvider>(
                                                builder: (context, favoriteData,
                                                    child) {
                                                  return IconButton(
                                                    onPressed: () {
                                                      if (favoriteData.isFavor(
                                                          songModel[index])) {
                                                      // Provider.of<FavoriteProvider>(context).delete(
                                                      //       songModel[index]
                                                      //           .id);
                                                      favoriteData.delete(songModel[index].id);

                                                        const removed =
                                                            SnackBar(
                                                          content: Text(
                                                              'Song removed from favorite'),
                                                          duration: Duration(
                                                              seconds: 1),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                removed);
                                                      } else {
                                                        Provider.of<FavoriteProvider>(context).add(
                                                            songModel[index]);
                                                        const addFav = SnackBar(
                                                          content: Text(
                                                              'Song added to favorites'),
                                                          duration: Duration(
                                                              seconds: 1),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                addFav);
                                                      }

                                                      // favoriteData.favoriteSongs;
                                                      Navigator.pop(context);
                                                    },
                                                    icon: favoriteData.isFavor(
                                                            songModel[index])
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(
                                                            Icons.favorite,
                                                            color: Colors.black,
                                                          ),
                                                  );
                                                },
                                              ),
                                              Consumer<FavoriteProvider>(
                                                  builder: (context,
                                                      favoriteDatas, child) {
                                                return TextButton(
                                                  onPressed: () {
                                                    if (favoriteDatas.isFavor(
                                                        songModel[index])) {
                                                      favoriteDatas.delete(
                                                          songModel[index].id);
                                                      const remove = SnackBar(
                                                        content: Text(
                                                            'Song removed from favorites'),
                                                        duration: Duration(
                                                            seconds: 1),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(remove);
                                                    } else {
                                                      favoriteDatas.add(
                                                          songModel[index]);
                                                      const addFav = SnackBar(
                                                        content: Text(
                                                            'Song added to favorites'),
                                                        duration: Duration(
                                                            seconds: 1),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(addFav);
                                                    }
                                                    favoriteDatas.favoriteSongs;

                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Favorites song",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  ),
                                                );
                                              })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_vert),
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onTap: () {
                        Getallsong.audioplayer.setAudioSource(
                          Getallsong.createSongList(songModel),
                          initialIndex: index,
                        );
                        // MostlyPlayed.addcount(
                        //   songModel[index].id,
                        // );
                        // MostlyPlayed.addmostlyPlayed(songModel[index].id);
                        Provider.of<MostlyPlayedProvider>(context,
                                listen: false)
                            .addmostlyPlayed(songModel[index].id);
                        // Recentlysong.addrecentlyplayed(songModel[index].id);
                        Provider.of<RecentlyProvider>(context, listen: false)
                            .addrecentlyplayed(songModel[index].id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NowPlaying(
                                songModel: songModel, count: songModel.length),
                          ),
                        );
                      }),
                )));
      },
    );
  }
}
