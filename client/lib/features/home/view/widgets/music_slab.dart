import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/providers/current_song_notifier.dart';
import 'package:spotify_clone/core/providers/current_user_notifier.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/view/widgets/music_player.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final songNotifier = ref.read(currentSongProvider.notifier);
    final userFavourites = ref.watch(currentUserProvider.select((data) => data!.favourites));

    if (currentSong == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const MusicPlayer();
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final tween = Tween(begin: Offset(1, 0),end: Offset(0, 1)).chain(CurveTween(curve: Curves.easeIn));
              final offsetAnimation = animation.drive(tween);
            
              return SlideTransition(position: offsetAnimation,child: child);
            },
          ),
        );
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 66,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: hexToColor(currentSong.hex_code), borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'music-image',
                      child: Container(
                        width: 48,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(currentSong.thumbnail_url), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.song_name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Pallete.whiteColor),
                        ),
                        Text(
                          currentSong.artist,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Pallete.whiteColor),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {await ref.read(homeViewModelProvider.notifier).favSong(songId: currentSong.id);},
                      icon: Icon(userFavourites.where((fav) =>fav.song_id == currentSong.id).toList().isNotEmpty ? CupertinoIcons.heart_fill : CupertinoIcons.heart),
                    ),
                    IconButton(onPressed: songNotifier.playPause,icon: Icon(songNotifier.isPlaying ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill)),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: songNotifier.audioPlayer?.positionStream,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              final position = asyncSnapshot.data;
              final duration = songNotifier.audioPlayer!.duration;

              double sliderValue = 0.0;
              if (position != null && duration != null) {
                sliderValue = position.inMilliseconds / duration.inMilliseconds;
              }

              return Positioned(
                bottom: 0,
                left: 8,
                child: Container(
                  height: 2,
                  width: sliderValue * (MediaQuery.of(context).size.width - 16),
                  decoration: const BoxDecoration(color: Pallete.whiteColor),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 8,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 16,
              decoration: BoxDecoration(color: Pallete.inactiveSeekColor, borderRadius: BorderRadius.circular(7)),
            ),
          ),
        ],
      ),
    );
  }
}
