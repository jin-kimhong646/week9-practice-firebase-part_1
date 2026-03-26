import 'package:flutter/material.dart';
import '../../../../model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({super.key, required this.artist});

  final Artist artist;

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
          onTap: () {},
          leading: ClipOval(
            child: Image.network(
              '${artist.imageUrl}',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(artist.name),
          subtitle: Text(artist.genre),
        ),
      ),
    );
  }
}