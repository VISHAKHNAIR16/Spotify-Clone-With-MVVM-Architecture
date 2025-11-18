import 'dart:io';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/providers/current_user_notifier.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/models/fav_song_model.dart';
import 'package:spotify_clone/features/home/models/song_model.dart';
import 'package:spotify_clone/features/home/repositories/home_local_repository.dart';
import 'package:spotify_clone/features/home/repositories/home_repository.dart';
part 'home_viewmodel.g.dart';



@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {

  final token = ref.watch(currentUserProvider.select((user) => user!.token));
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);

  return  switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}


@riverpod
Future<List<SongModel>> getAllFavSongs(Ref ref) async {

  final token = ref.watch(currentUserProvider.select((user) => user!.token));
  final res = await ref.watch(homeRepositoryProvider).getAllFavSongs(token: token);

  return  switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}


@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalrepository _homeLocalrepository;

  @override
  AsyncValue? build() {
    _homeLocalrepository = ref.watch(homeLocalrepositoryProvider);
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong  ({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: rgbToHex(selectedColor),
      token: ref.read(currentUserProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value:final r) => state = AsyncValue.data(r),
    };


    print(val);
  }


  Future<void> favSong ({
    required String songId
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.favSong(
      songId: songId,
      token: ref.read(currentUserProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value:final r) => state = _favSongSuccess(r, songId),
    };


    print(val);
  }


  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalrepository.loadSongs();
  }


  _favSongSuccess(bool isFav,String song_id) {
     final userNotifier  = ref.read(currentUserProvider.notifier);
    if(isFav) {
      userNotifier.addUser(
        ref.read(currentUserProvider)!.copyWith(
          favourites: [
            ...ref.read(currentUserProvider)!.favourites,
            FavSongModel(id: '', song_id: song_id, user_id: '')
          ]
        )
      );
    }else{
      userNotifier.addUser(
        ref.read(currentUserProvider)!.copyWith(
          favourites: ref.read(currentUserProvider)!.favourites.where((fav) => fav.song_id != song_id,).toList(),
        )
      );
    }
    ref.invalidate(getAllSongsProvider);
    return state = AsyncValue.data(isFav);
  }
}
