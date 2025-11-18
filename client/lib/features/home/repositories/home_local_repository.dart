import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/models/song_model.dart';
part 'home_local_repository.g.dart';



@riverpod
HomeLocalrepository homeLocalrepository(Ref ref) {
  return HomeLocalrepository();
}



class HomeLocalrepository {
  final Box box = Hive.box();

  void uploadLocalSong(SongModel song) {
    box.put(song.id,song.toJson());
  }


  List<SongModel> loadSongs() {
    List<SongModel> songs = [];

    for(final key in box.keys) {
      songs.add(SongModel.fromJson(box.get(key)));
    }

    return songs;
  }
}