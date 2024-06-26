import 'package:reper/domain/datasources/song_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/repositories/song_repository.dart';

class SongRepositoryImpl extends SongRepository {
  final SongDatasource datasource;

  SongRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> createSong({required Song song}) {
    return datasource.createSong(song: song);
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
  
  @override
  Future<Song> getSong({required String songId}) {
    return datasource.getSong(songId: songId);
  }
  
  @override
  Stream<List<Song>> streamFavoriteSongs({required List<String> songs}) {
    return datasource.streamFavoriteSongs(songs: songs);
  }

  
}
