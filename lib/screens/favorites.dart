import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/provider/favoriteProvider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'listviewscreen.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Consumer<FavoriteProvider>(
      builder:(context, value, child) {
        
      
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title:const Text('favorites'),
          backgroundColor: backgroundColor,
          actions:[ Consumer<FavoriteProvider>(
            builder: (context, value, child) {
              return
             IconButton(onPressed: (){
              value.clearFunction();
            }, icon:const Icon( Icons.clear));
            },
          ),
          ]
        ),
        body: Consumer<FavoriteProvider>(
         
          builder: (ctx,  favoriteData,  child) {
            if (favoriteData.favoriteSongs.isEmpty) {
              return const Center(
                child: Text('No Favorite Data',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              );
            } else {
              final  temp = favoriteData.favoriteSongs.reversed.toList();
             List<SongModel> favoritedatas = temp.toSet().toList();
              return ListViewScreen(songModel: favoritedatas, isMostly: false,);
            }
        
          
        },
        



        )
        );
      }
    
    
      );
    
  }
}
