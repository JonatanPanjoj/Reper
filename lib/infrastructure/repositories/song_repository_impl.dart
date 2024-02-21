import 'package:reper/domain/datasources/song_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/repositories/song_repository.dart';

class SongRepositoryImpl extends SongRepository {
  final SongDatasource datasource;

  SongRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> createSong({required Song song, required AppUser user}) {
    return datasource.createSong(song: song, user: user);
  }

  @override
  Future<ResponseStatus> deleteSong({required String songId}) {
    return datasource.deleteSong(songId: songId);
  }

  @override
  Future<ResponseStatus> getUserSongs({required String uid}) {
    return datasource.getUserSongs(uid: uid);
  }

  @override
  Stream<List<Song>> streamSongsByUser({required String uid}) {
    return datasource.streamSongsByUser(uid: uid);
  }

  @override
  Future<ResponseStatus> updateSong({required Song song}) {
    return datasource.updateSong(song: song);
  }
  
  @override
  Stream<Song> streamSong({required String songId}) {
    return datasource.streamSong(songId: songId);
  }
}
