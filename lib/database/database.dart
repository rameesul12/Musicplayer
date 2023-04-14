

 import 'package:hive_flutter/hive_flutter.dart';

part 'database.g.dart';

@HiveType(typeId:1)
class MusicWorld extends HiveObject {
  MusicWorld({required this.name, required this.songId,});

  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songId;

  @HiveField(2)
 late List<int> count;

  playlistadd(int id) async {
    songId.add(id);
    save();
  }

  deleteData(int id) {
    songId.remove(id);
    save();
  }
 bool isValueIn(int id) {
    return songId.contains(id);
  }
}
