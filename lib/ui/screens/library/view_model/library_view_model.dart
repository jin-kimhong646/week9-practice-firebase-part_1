import 'package:flutter/material.dart';
import 'package:w9_part1/data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';
import 'library_item_data.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final ArtistRepository artistRepository;

  AsyncValue<List<LibraryItemData>> songsData = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsData = AsyncValue.loading();
    notifyListeners();

    try {
      // 1- Fetch songs
      List<Song> songs = await songRepository.getSongs();

      // 2- Fethc artist
      List<Artist> artists = await artistRepository.getArtists();

      // 3- Create the mapping artistid-> artist
      Map<String, Artist> mapArtist = {};
      for (Artist artist in artists) {
        mapArtist[artist.id] = artist;
      }

      List<LibraryItemData> data = songs
          .map(
            (song) =>
                LibraryItemData(song: song, artist: mapArtist[song.artistId]!),
          )
          .toList();

      songsData = AsyncValue.success(data);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsData = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> likeIncreasement(String songId, int currentLikeCount) async {
    try {
      await songRepository.likeIncreasement(songId, currentLikeCount); 
      fetchSong();
    } catch (e) {
      throw Exception("can not increase the like");
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
