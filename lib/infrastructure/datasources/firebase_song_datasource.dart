import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:reper/domain/datasources/song_datasource.dart';
import 'package:reper/domain/entities/shared/response_status.dart';
import 'package:reper/domain/entities/song.dart';

class FirebaseSongDatasource extends SongDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<ResponseStatus> createSong({required Song song}) async {
    try {
      final WriteBatch batch = _database.batch();
      final ref = _database.collection('songs').doc();
      batch.set(
        ref,
        song.copyWith(id: ref.id, createdBy: _auth.currentUser!.uid).toJson(),
      );
      await batch.commit();
      return ResponseStatus(
        message: 'Canción creada con éxito',
        hasError: false,
      );
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> deleteSong({required String songId}) async {
    try {
      await _database.collection('songs').doc(songId).delete();
      
      return ResponseStatus(
        message: 'Canción eliminada con éxito',
        hasError: false,
      );
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> getUserSongs({required String uid}) {
    // TODO: implement getUserSongs
    throw UnimplementedError();
  }

  @override
  Stream<List<Song>> streamSongsByUser({required String uid}) {
    return _database
        .collection('songs')
        .where('created_by', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Song.fromJson(doc.data())).toList());
  }

  @override
  Future<ResponseStatus> updateSong({required Song song}) {
    // TODO: implement updateSong
    throw UnimplementedError();
  }
}
