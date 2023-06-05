import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicapp/database/recentlyDb.dart';
import 'package:musicapp/playlist/dialogue.dart';
import 'package:musicapp/provider/favoriteProvider.dart';
import 'package:musicapp/provider/homeProvider.dart';
import 'package:musicapp/provider/mostlyPlayed.dart';
import 'package:musicapp/provider/playlistProvider.dart';
import 'package:musicapp/widgets/splash.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(MusicWorldAdapter().typeId)) {
    Hive.registerAdapter(MusicWorldAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<int>('FavoriteDB');
  await Hive.openBox<MusicWorld>('playlistDb');
  await Hive.openBox('recentlyDb');
  await Hive.openBox('mostlyPlayedDb');


  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) =>FavoriteProvider() , ),
        ChangeNotifierProvider(create: (context) => HomeProvider(),),
        ChangeNotifierProvider(create: (context) => RecentlyProvider(),),
        ChangeNotifierProvider(create: (context) => MostlyPlayedProvider(),),
        ChangeNotifierProvider(create: (context) => DialogueProvider(),),
        ChangeNotifierProvider(create: (context) => PlaylistProvider(),)
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home:splashscreen(),
      ),
    );
  }
}