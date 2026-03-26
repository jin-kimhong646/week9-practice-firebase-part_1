import '../../model/artists/artist.dart';

class ArtistDto {
  static final String artistNameKey = 'name';
  static final String artistGenreKey = 'genre';
  static final String imageUrlKey = 'imageUrl';

  static Artist fromJson(String id, Map<String, dynamic> json) {
    assert(json[artistNameKey] is String);
    assert(json[artistGenreKey] is String);
    assert(json[imageUrlKey] is String);

    return Artist(
      id: id,
      name: json[artistNameKey],
      genre: json[artistGenreKey],
      imageUrl: Uri.parse(json[imageUrlKey]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Artist artist) {
    return {
      artistNameKey: artist.name,
      artistGenreKey: artist.genre,
      imageUrlKey: artist.imageUrl.toString(),
    };
  }
}