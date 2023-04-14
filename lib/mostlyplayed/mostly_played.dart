import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/screens/listviewscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'mostlydb.dart';

class ScreenMostlyPlayed extends StatefulWidget {
  const ScreenMostlyPlayed({super.key});

  @override
  State<ScreenMostlyPlayed> createState() => _ScreenMostlyPlayedState();
}

class _ScreenMostlyPlayedState extends State<ScreenMostlyPlayed> {
  OnAudioQuery onAudioQuery = OnAudioQuery();
  List<SongModel> mostlyPlayedSongLIst = [];
  @override
  void initState() {
    // MostlyPlayed.getMostlyPlayed();
    getMostPlayedSongs();
    super.initState();
  }
   Future<void> getMostPlayedSongs() async {
    await MostlyPlayed.getMostlyPlayed();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Mostly Played',
          style: TextStyle(color: white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Songs',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: white),
              ),
            ),
            // const SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder(
                future: MostlyPlayed.getMostlyPlayed(),
                builder: (context, items) {
                  return ValueListenableBuilder(
                    valueListenable: MostlyPlayed.mostlyPlayedSongNotifier,
                    builder: (context, List<SongModel> data, Widget? child) {
                      if (data.isEmpty) {
                        return const Center(
                          child: Text(
                            'No songs ',
                            style: TextStyle(color: white),
                          ),
                        );
                      } else {
                        mostlyPlayedSongLIst = data.reversed.toSet().toList();
                        return FutureBuilder<List<SongModel>>(
                          future: onAudioQuery.querySongs(
                            sortType: null,
                            orderType: OrderType.ASC_OR_SMALLER,
                            uriType: UriType.EXTERNAL,
                            ignoreCase: true,
                          ),
                          builder: (context, items) {
                            if (items.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (items.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No songs found',
                                  style: TextStyle(color: white),
                                ),
                              );
                            }
                            return ListViewScreen(
                              songModel: mostlyPlayedSongLIst,
                              isMostly: true,
                              recentlength: mostlyPlayedSongLIst.length > 8
                                  ? 8
                                  : mostlyPlayedSongLIst.length,
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

 
}