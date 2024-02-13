import 'package:reper/domain/entities/entities.dart';

abstract class SongDatasource {
  Future<ResponseStatus> createSong({required Song song});

  Stream<List<Song>> streamSongsByUser({required String uid});

  Future<ResponseStatus> updateSong({required Song song});

  Future<ResponseStatus> deleteSong({required String songId});

  Future<ResponseStatus> getUserSongs({required String uid});
}
