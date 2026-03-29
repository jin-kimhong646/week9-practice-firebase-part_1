import 'package:flutter/material.dart';
import 'package:w9_part1/ui/screens/library/view_model/library_item_data.dart';

class SongTile extends StatelessWidget {
  final LibraryItemData libraryItemData;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onLike;

  const SongTile({
    super.key,
    required this.libraryItemData,
    required this.isPlaying,
    required this.onTap,
    required this.onLike,
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
          subtitle: Row(
            spacing: 10,
            children: [
              Text('${libraryItemData.song.duration.inMinutes} mins'),
              Text('${libraryItemData.artist.name} '),
              Text(' - ${libraryItemData.artist.genre}'),
              Text('--- ${libraryItemData.song.likeCount} Likes'),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onLike,
                icon: Icon(Icons.favorite, color: Colors.red[300]),
              ),
              Text(
                isPlaying ? "Playing" : "",
                style: TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
