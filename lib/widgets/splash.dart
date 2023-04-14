import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:musicapp/widgets/home.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  
@override
  void initState() {
    super.initState();
  navigatehome();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 24, 41),
    body: Center(
      child:SafeArea(child: 
      SizedBox(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        height: 200,
        width: 200,
        child: Center(
          child: AnimatedTextKit(animatedTexts: [
            TyperAnimatedText('Music App',textStyle:const TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold)),
            TyperAnimatedText('Build by \nFlutter',textStyle:const TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold))
          ]),
        ),
        ),
      )
      ) ,
    );
  
    }

    navigatehome()async{
      await Future.delayed (const Duration(seconds: 3));
     // ignore: use_build_context_synchronously
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const homepage(songModel: [],)));
    
    }
  
}