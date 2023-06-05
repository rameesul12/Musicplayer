import 'package:flutter/material.dart';
import 'package:musicapp/Miniplayer/miniplayer.dart';
import 'package:musicapp/mostlyplayed/mostly_played.dart';
import 'package:musicapp/provider/favoriteProvider.dart';
import 'package:musicapp/provider/homeProvider.dart';
import 'package:musicapp/screens/favorites.dart';
import 'package:musicapp/search/search.dart';
import 'package:musicapp/settings/settings.dart';
import 'package:musicapp/widgets/nowplaying/onplaying.dart';
import 'package:provider/provider.dart';
import '../Recentlyplayed/recentlyPlayed.dart';
import '../colorvariables/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/get_all_song.dart';
import '../database/recentlyDb.dart';
import '../playlist/playlist.dart';

import '../screens/listviewscreen.dart';

// ignore: camel_case_types
class homepage extends StatelessWidget {
  homepage({super.key, required List<SongModel> songModel});

  final audioquery = OnAudioQuery();

  // bool isFavorite = false;

  // bool isFavor = false;

  @override
  // void initState() {
  //   super.initState();

  //   requestpermission();
  // }

  // void requestpermission() async{
  //   bool permissionStatus=await audioquery.permissionsStatus();
  //   if (!permissionStatus) {
  //      await audioquery.permissionsRequest();
  //   }
  //   setState(() {
  //   Permission.storage.request();
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homevalue, Widget) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<HomeProvider>(context, listen: false).requestpermission();
      });
      return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                },
                icon: const Icon(Icons.settings)),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ));
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                  height: 130,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Favourites(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cardcolor,
                              border: Border.all(width: 3, color: white)),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Favorites',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlaylistPage(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 3, color: Colors.white),
                            color: Colors.white10,
                          ),
                          child: const SingleChildScrollView(
                              child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.playlist_add,
                                    size: 30, color: Colors.white),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'playlist    ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Recentlyplayed())),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 3, color: white),
                            color: cardcolor,
                          ),
                          child: const SingleChildScrollView(
                              child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Recently \nplayed',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                     ScreenMostlyPlayed(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white10,
                              border: Border.all(width: 3, color: white)),
                          child: const SingleChildScrollView(
                              child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.filter_vintage,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Mostly \nplayed   ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                  ])),
              const SizedBox(
                height: 35,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'All songs',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                // flex: 4,
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: FutureBuilder<List<SongModel>>(
                        future: audioquery.querySongs(
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
                                child: Text(
                              "No Songs Found!! ",
                              style: TextStyle(color: white),
                            ));
                          }
                          startsong = item.data!;
                          if (!Provider.of<FavoriteProvider>(context,
                                  listen: false)
                              .isInitialized) {
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .initialize(item.data!);
                          }
                          Getallsong.songcopy = item.data!;
                          return ListViewScreen(songModel: item.data!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: SizedBox(
                        // height: 65,
                        // width: double.infinity,
                        // color: Colors.transparent,
                        child: Consumer<RecentlyProvider>(
                          //  valueListenable: Recentlysong.recentnotifier,
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                if (Getallsong.audioplayer.currentIndex != null)
                                  InkWell(
                                      onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => NowPlaying(
                                                songModel:
                                                    Getallsong.playingsong),
                                          )),
                                      child: const MiniPlayer())
                                else
                                  const SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ));
    });
  }
}

List<SongModel> startsong = [];
