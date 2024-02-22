import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reper/infrastructure/datasources/firebase_song_datasource.dart';
import 'package:reper/infrastructure/repositories/song_repository_impl.dart';

final songsRepositoryProvider = Provider((ref) {
  return SongRepositoryImpl(FirebaseSongDatasource());
});
