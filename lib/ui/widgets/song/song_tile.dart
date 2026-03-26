import 'package:flutter/material.dart';
import 'package:w9_part1/ui/screens/library/view_model/library_item_data.dart';


class SongTile extends StatelessWidget {
  final LibraryItemData libraryItemData;
  final bool isPlaying;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.libraryItemData,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: ClipOval(
            child: Image.network(
              '${libraryItemData.song.imageUrl}',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(libraryItemData.song.title),
          subtitle: Text(
            '${libraryItemData.song.duration.inMinutes} mins ${libraryItemData.artist.name} - ${libraryItemData.artist.genre}',
          ),

          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
