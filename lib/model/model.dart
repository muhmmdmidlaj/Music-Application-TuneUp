import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class PlayModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songid;

  PlayModel({required this.name, required this.songid});

  add(int id) {
    songid.add(id);
    save();
  }

  deletedata(int id) {
    songid.remove(id);
    save();
  }

  bool isvalule(int id) {
    return songid.contains(id);
  }
}
