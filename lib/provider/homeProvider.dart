import 'package:flutter/material.dart';
import 'package:musicapp/search/search.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeProvider extends ChangeNotifier{


  void requestpermission() async{
    bool permissionsStatus=await audioquery.permissionsStatus();
   if(!permissionsStatus){
    await audioquery.permissionsRequest();
   }
   Permission.storage.request();
   notifyListeners();
  }
}