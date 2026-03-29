class Song {
  final String id;
  final String title;
  final String artistId;
  final Duration duration;
  final Uri imageUrl;
  final int likeCount;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    required this.duration,
    required this.imageUrl,
    required this.likeCount, 
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artistId, duration: $duration , uri: $imageUrl , likeAmount:$likeCount)';
  }
}
