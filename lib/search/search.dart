import 'package:flutter/material.dart';
import 'package:musicapp/colorvariables/colors.dart';
import 'package:musicapp/screens/listviewscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
List<SongModel>allSong=[];
  List<SongModel>foundSong=[];
  final audioquery=OnAudioQuery();

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    songloading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:AppBar(
         iconTheme: const IconThemeData(color: white),
        backgroundColor: backgroundColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          
        }, icon:const Icon(Icons.arrow_back)),
        title: TextField(
          textAlign: TextAlign.start,
          onChanged: (value) => updation(value),
          style:const TextStyle(
            color: white,
          ),
          decoration: InputDecoration(
            hintStyle:const TextStyle(color: white),
            hintText: 'Search Song',
            fillColor: Colors.black,
            filled:true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none
              
          )
 ),
        ),
        
      ),
      body: foundSong.isNotEmpty ?ListViewScreen(songModel: foundSong):
      const Center(child: Text('No Song Found', style: TextStyle(color: white),),),
    
    );
 }

void songloading() async{
  allSong=await audioquery.querySongs(
sortType: null,
orderType: OrderType.ASC_OR_SMALLER,
ignoreCase: true,
uriType: UriType.EXTERNAL,
  );
  setState(() {
    foundSong=allSong;
  });
}

void updation(String enteredtext){
  List<SongModel>result=[];
  if(enteredtext.isEmpty){

  result=allSong;
  
  }else{
    
   for (var element in allSong) {
    var res=element.displayNameWOExt.toLowerCase().trim().contains(enteredtext.toLowerCase().trim());
    if (res==true) {
      result.add(element);
    }
     
     setState(() {
       foundSong=result;
     });
   } 
  }

    
  }
}
