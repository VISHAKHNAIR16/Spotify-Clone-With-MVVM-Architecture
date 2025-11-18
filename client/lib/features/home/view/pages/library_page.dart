import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/providers/current_song_notifier.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/widgets/loading.dart';
import 'package:spotify_clone/features/home/view/pages/upload_song_page.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';

class Librarypage extends ConsumerWidget {
  const Librarypage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getAllSongsProvider)
        .when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadSongPage()));
                    },
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundColor: Pallete.backgroundColor,
                      child: Icon(CupertinoIcons.plus),
                    ),
                    title: Text("Upload New Song", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  );
                }
                final song = data[index];
                return ListTile(
                  onTap: () {
                    ref.read(currentSongProvider.notifier).updateSong(song);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(song.thumbnail_url),
                    radius: 35,
                    backgroundColor: Pallete.backgroundColor,
                  ),
                  title: Text(song.song_name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  subtitle: Text(song.artist, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                );
              },
            );
          },
          error: (error, st) {
            return Center(child: Text(error.toString()));
          },
          loading: () => const Loader(),
        );
  }
}
