

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicapp/colorvariables/colors.dart';
import '../database/database.dart';
import 'dialogue.dart';
import 'playlist_List.dart';

class PlaylistGridView extends StatefulWidget {
  const PlaylistGridView({
    Key? key,
    required this.musicList,
  }) : super(key: key);
  final Box<MusicWorld> musicList;
  @override
  State<PlaylistGridView> createState() => _PlaylistGridViewState();
}

class _PlaylistGridViewState extends State<PlaylistGridView> {
  final TextEditingController playlistnamectrl = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
var pics=[
  "asset/images/images (1).jpg",
  "asset/images/track.jpg",
  "asset/images/images.jpg",
  "asset/images/imagy.jpg",
  "asset/images/muscii.jpg",
  "asset/images/images (4).jpg",
  "asset/images/images (2).jpg"

  ];
  // bool pickscheck=false;
  // checker(index){

  // }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        shrinkWrap: true,
        itemCount: widget.musicList.length,
        itemBuilder: (context, index) {
          final data = widget.musicList.values.toList()[index];
          return ValueListenableBuilder(
            valueListenable: Hive.box<MusicWorld>('playlistDb').listenable(),
            builder: (BuildContext context, Box<MusicWorld> musicList,
                Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SinglePlaylist(
                            playlist: data,
                            findex: index,
                            photo:
                                'asset/images/music.jpg',
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Container(
                        //  margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                             pics[index]
                            ))
                          ),
                          height: MediaQuery.of(context).size.height * 2 / 10,
                          width: MediaQuery.of(context).size.height * 2 / 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.90 /
                                    4,
                                child: Text(
                                  data.name,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color:
                                         white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 40,
                             
                                  child: IconButton(
                                    onPressed: () {
                                      moredialogplaylist(
                                          context,
                                          index,
                                          musicList,
                                          formkey,
                                          playlistnamectrl,
                                          data);
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color:
                                          white,
                                    ),
                                  ),
                                ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
