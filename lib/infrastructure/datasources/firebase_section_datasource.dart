import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reper/domain/datasources/section_datasource.dart';
import 'package:reper/domain/entities/section.dart';
import 'package:reper/domain/entities/shared/response_status.dart';

class FirebaseSectionDatasource extends SectionDatasource {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<ResponseStatus> createSection(
      {required String groupId,
      required String repertoryId,
      required Section section}) async {
    try {
      final WriteBatch batch = _database.batch();
      final ref = _database
          .collection('groups')
          .doc(groupId)
          .collection('repertories')
          .doc(repertoryId)
          .collection('sections')
          .doc();

      final repertoryRef = _database
          .collection('groups')
          .doc(groupId)
          .collection('repertories')
          .doc(repertoryId);

      batch.update(repertoryRef, {
        'sections': FieldValue.arrayUnion([ref.id])
      });
      batch.set(ref, section.copyWith(id: ref.id).toJson());
      await batch.commit();

      return ResponseStatus(
          message: 'Sección agregada con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Stream<List<Section>> streamSections(
      {required String groupId, required String repertoryId}) {
    return _database
        .collection('groups')
        .doc(groupId)
        .collection('repertories')
        .doc(repertoryId)
        .collection('sections')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Section.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<ResponseStatus> deleteSection({
    required String groupId,
    required String repertoryId,
    required String sectionId,
  }) async {
    try {
      final WriteBatch batch = _database.batch();

      final sectionRef = _database
          .collection('groups/$groupId/repertories/$repertoryId/sections')
          .doc(sectionId);

      final repertoryRef =
          _database.collection('groups/$groupId/repertories').doc(repertoryId);

      batch.delete(sectionRef);
      batch.update(repertoryRef, {
        'sections': FieldValue.arrayRemove([sectionRef.id])
      });

      await batch.commit();

      return ResponseStatus(
          message: 'Repertorio eliminado con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }
}
