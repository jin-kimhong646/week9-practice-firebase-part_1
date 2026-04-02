import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/dtos/artist_dto.dart';
import '../../../data/repositories/artists/artist_repository.dart';
import '../../../model/artists/artist.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = Uri.https(
    'g2-the-best-76f22-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  List<Artist>? _cachedArtist;

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      return artistJson.entries
          .map((artist) => ArtistDto.fromJson(artist.key, artist.value))
          .toList();
    } else {
      throw Exception('Fail to load artist');
    }
  }

  @override
  Future<Artist?> fetchAristsById(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Artist>> getArtists() async {
    if (_cachedArtist != null) {
      return _cachedArtist!;
    }

    List<Artist> artists = await fetchArtists();
    _cachedArtist = artists;
    print("fetch artist from DB");
    return artists;
  }
}
