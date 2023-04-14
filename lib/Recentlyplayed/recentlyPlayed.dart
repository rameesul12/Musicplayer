import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/database/recentlyDb.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../screens/listviewscreen.dart';

class Recentlyplayed extends StatefulWidget {
  const Recentlyplayed({super.key});

  @override
  State<Recentlyplayed> createState() => _RecentlyplayedState();
}

class _RecentlyplayedState extends State<Recentlyplayed> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  static List<SongModel> recentSong = [];

  @override
  void initState() {
    recent();
    super.initState();
  }

  Future<void> recent() async {
  await  Recentlysong.getrecentsong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
          leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon:const Icon(Icons.arrow_back),
      ),
      title:const Text('Recently played',style: TextStyle(color: white),),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
            future: Recentlysong.getrecentsong(),
            builder: (context, items) {
              return ValueListenableBuilder(
                  valueListenable: Recentlysong.recentnotifier,
                  builder: (context, List<SongModel> value, Widget? child) {
                    if (value.isEmpty) {
                      return const Center(
                        child: Text(
                          'No song found',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      final temp = value.reversed.toList();

                      recentSong = temp.toSet().toList();
                      return FutureBuilder<List<SongModel>>(
                        future: audioQuery.querySongs(
                          sortType: null,
                          orderType: OrderType.ASC_OR_SMALLER,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true,
                        ),
                        builder: (context, item) {
                          if (item.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (item.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                'no song available',
                                style: TextStyle(color: white),
                              ),
                            );
                          }
                          return ListViewScreen(
                            songModel: recentSong,
                            isRecent: true,
                            recentlength:
                                recentSong.length > 8 ? 8 : recentSong.length, 
                          );
                        },
                      );
                    }
                  });
            }),
      ),
    );
  }
}
