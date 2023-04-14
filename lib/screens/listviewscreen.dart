

import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/controller/get_all_song.dart';
import 'package:musicapp/database/recentlyDb.dart';
import 'package:musicapp/mostlyplayed/mostlydb.dart';
import 'package:musicapp/playlist/playlistadding/addtoplaylist.dart';
import 'package:musicapp/widgets/nowplaying/onplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../database/favoritedb.dart';

class ListViewScreen extends StatefulWidget {
 

  const ListViewScreen(
      {super.key,
      required this.songModel,
       this.recentlength,
        this.isRecent=false,  this.isMostly=false,
     
      
      });
  final List<SongModel> songModel;
 final dynamic recentlength;
 final bool isRecent;
 final bool isMostly;
 

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  
  List<SongModel> allSongs = [];
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:widget.isRecent?widget.recentlength: widget.songModel.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        allSongs.addAll(widget.songModel);
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
                  id: widget.songModel[index].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 50,
                  artworkHeight: 50,
                  keepOldArtwork: true,
                  artworkBorder: BorderRadius.circular(6),
                  nullArtworkWidget: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color:
                         Colors.white12,
                    ),
                    height: 50,
                    width: 50,
                    child:const Icon(
                      Icons.music_note,
                      color:
                          white,
                    ),
                  ),
                ),
                title: Text(
                  widget.songModel[index].displayNameWOExt,
                  style:const TextStyle(
                    color: Colors.white
                  ),
                 
                  maxLines: 1,
                ),
                subtitle: Text(
                  widget.songModel[index].artist.toString(),
                  style:const TextStyle(
                    color: Colors.white
                  ),
                  
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
                                      const  Icon(
                                              Icons.playlist_add,
                                              size: 30,
                                            ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                           dialoguePlaylist(context,
                                                widget.songModel[index]);
                                            },
                                
                                            child:
                                            
                                            const Text(
                                          " Add to playlist",
                                          style: TextStyle(fontSize: 20,color: Colors.black),
                                        ), ),
                                        
                                      
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ValueListenableBuilder(
                      valueListenable: FavoriteDb.favoriteSongs,
                      builder: (context, List<SongModel> favoriteData, child) {
                        return IconButton(
                          onPressed: () {
                            if (FavoriteDb.isFavor(widget.songModel[index])) {
                              FavoriteDb.delete(widget.songModel[index].id);
                              const remove = SnackBar(
                                content: Text('Song removed from favorites'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(remove);
                            } else {
                              FavoriteDb.add(widget.songModel[index]);
                              const addFav = SnackBar(
                                content: Text('Song added to favorites'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(addFav);
                            }
                            FavoriteDb.favoriteSongs.notifyListeners();
                          },
                          icon: FavoriteDb.isFavor(widget.songModel[index])
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
                                       TextButton(onPressed: (){
                                         if (FavoriteDb.isFavor(widget.songModel[index])) {
                              FavoriteDb.delete(widget.songModel[index].id);
                              const remove = SnackBar(
                                content: Text('Song removed from favorites'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(remove);
                            } else {
                              FavoriteDb.add(widget.songModel[index]);
                              const addFav = SnackBar(
                                content: Text('Song added to favorites'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(addFav);
                            }
                            FavoriteDb.favoriteSongs.notifyListeners();
                          },
                                       
                                       child:  const Text(
                                          "Favorites song",
                                          style: TextStyle(fontSize: 20,color: Colors.black),
                                        ),)
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
                    Getallsong.createSongList(widget.songModel),
                     initialIndex: index,
                   );
                    MostlyPlayed.addcount(widget.songModel[index].id, );
                MostlyPlayed.addmostlyPlayed(widget.songModel[index].id);
                 Recentlysong.addrecentlyplayed(widget.songModel[index].id);
                          
                            Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => NowPlaying(
                                  
                                   songModel: widget.songModel,
                                    
                                   count:
                                    widget.songModel.length
                                 ),
                             ),
                             );
                   } ),
            ))
          );

                         },
                       );
                    
                   
   }   }
                
                    
        
    
  
    

    


