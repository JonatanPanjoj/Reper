import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/repositories/song_repository_impl.dart';
import 'package:reper/presentation/providers/database/songs_repository_provider.dart';

// Providers
final userSongsListProvider =
    StateNotifierProvider<UserSongListNotifier, List<Song>>((ref) {
  final songRepository = ref.watch(songsRepositoryProvider);

  return UserSongListNotifier(songRepository: songRepository);
});

// Controller
class UserSongListNotifier extends StateNotifier<List<Song>> {
  final SongRepositoryImpl songRepository;

  UserSongListNotifier({required this.songRepository}) : super([]);

  //Stream Songs
  streamUserSongs(String uid) {
    songRepository.streamSongsByUser(uid: uid).listen((songsList) {
      state = songsList;
    });
  }
}
