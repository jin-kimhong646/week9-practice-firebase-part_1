import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'g2-love-ronan-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);
      return songJson.entries
          .map((entry) => SongDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeIncreasement(String songId, int currentLikeCount) async {
    final Uri likeSongsUri = Uri.https(
      'g2-love-ronan-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$songId.json',
    );

    final http.Response response = await http.patch(
      likeSongsUri,
      body: json.encode({'likeCount': currentLikeCount + 1}),
    );

    if (response.statusCode != 200){
      throw Exception("sorry all bro and sis you can not like this song ");
    }
  }
}
