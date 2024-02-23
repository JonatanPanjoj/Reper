import 'package:reper/domain/entities/entities.dart';

abstract class SongDatasource {
  Future<ResponseStatus> createSong({required Song song, required AppUser user});

  Stream<List<Song>> streamSongsByUser({required String uid});

  Future<ResponseStatus> updateSong({required Song song});

  Future<ResponseStatus> deleteSong({required String songId});

  Stream<Song> streamSong({required String songId});

  Future<ResponseStatus> getUserSongs({required String uid});
}