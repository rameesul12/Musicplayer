



import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
final _audioplayer=AudioPlayer();

playsong(String? uri){
 try {
    _audioplayer.setAudioSource(
AudioSource.uri(Uri.parse(uri!), ) );
_audioplayer.play();
 } on Exception{
 debugPrint( 'error parsing song');
 }

}

