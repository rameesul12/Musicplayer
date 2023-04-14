import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/controller/get_all_song.dart';
import 'package:musicapp/database/recentlyDb.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  
  State<MiniPlayer> createState() => _MiniPlayerState();
  
}
bool firstSong=false;
bool isplaying=false;
class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:65 ,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        
        color:  Colors.white10,
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(10),
      
      ),
      child: Stack(
        children: [
          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             
              Container(
                margin:const EdgeInsets.only(left: 5),
               width: MediaQuery.of(context).size.width *1.5/4,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<bool>(
                    stream: Getallsong.audioplayer.playingStream,
                    builder:(context, snapshot) {
                      bool? playingstage=snapshot.data;
                      if (playingstage !=null && playingstage) {
                        return 
                         Text(
                          Getallsong.playingsong[Getallsong.audioplayer.currentIndex!].displayName,
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       textAlign: TextAlign.center ,
                       style: const TextStyle(color: white),
                        );
                      }else{
                        return Text(
                          Getallsong.playingsong[Getallsong.audioplayer.currentIndex!]
                           .displayName,
                           textAlign: TextAlign.center,
                           maxLines: 1,
                          style:const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: white,
                            fontWeight: FontWeight.bold)
                          
                            );
                      }
                    },
                    ), 
                   
                    Text(Getallsong.playingsong[Getallsong.audioplayer.currentIndex!].artist.toString()=="<unknown>"?
                    "unknown Artist":Getallsong.playingsong[Getallsong.audioplayer.currentIndex!].artist.toString(),
                    style: const TextStyle(
                      fontSize: 10,color: white,)
                    
                    )
                ],
               ),
              ),
          

              firstSong ? const IconButton
              (onPressed: null,
               icon: Icon(
                Icons.skip_previous,
                color: Colors.transparent,
               ))
               :IconButton(onPressed: ()async{
                Recentlysong.addrecentlyplayed(Getallsong.playingsong[Getallsong.audioplayer.currentIndex!].id);
              if (Getallsong.audioplayer.hasPrevious) {
                await Getallsong.audioplayer.seekToPrevious();
                await Getallsong.audioplayer.play();
              }else{
                  await Getallsong.audioplayer.pause();
              }
               }, icon:const Icon(Icons.skip_previous,color: white,)),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const CircleBorder(),
                      ),
                onPressed:()async{
                  setState(() {
                    isplaying=!isplaying;
                  });
                  if(Getallsong.audioplayer.playing){
                await Getallsong.audioplayer.pause();
                setState(() {});
                  }else{
                    await Getallsong.audioplayer.play();
                     setState(() {});
                  }
                } , child: StreamBuilder<bool>(
                  stream: Getallsong.audioplayer.playingStream,
                  builder: (context, snapshot) {
                    bool ? playingstage=snapshot.data;
                    if(playingstage !=null && playingstage){
                      return const Icon(
                        Icons.pause_circle,
                        color: Colors.blue,
                        size: 30,
                      );
                    }else{
                      return const Icon(
                        Icons.play_circle,
                        color: white,
                        size: 30,);
                       
                    }
                  },
                )
                ),
                IconButton(
                  iconSize: 30,
                  onPressed: ()async{
                    Recentlysong.addrecentlyplayed(Getallsong
                    .playingsong[Getallsong.audioplayer.currentIndex!].id
                    );
                    if(Getallsong.audioplayer.hasNext){
                      await Getallsong.audioplayer.seekToNext();
                      await Getallsong.audioplayer.play();
                    }else{
                      await Getallsong.audioplayer.play();
                    }
                  },
                   icon:const Icon(Icons.skip_next,color: white,)
                   
                   )
            ],
          )
        ],
      ),
    );
  }
}