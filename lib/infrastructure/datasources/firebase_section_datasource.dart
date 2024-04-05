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

  @override
  Future<ResponseStatus> updateSection(
      {required Section section,
      required String groupId,
      required String repertoryId}) async {
    try {
      await _database
          .collection('groups/$groupId/repertories/$repertoryId/sections')
          .doc(section.id)
          .update(section.toJson());

      return ResponseStatus(message: 'Actualizado con éxito', hasError: false);
    } on FirebaseException catch (e) {
      return ResponseStatus(
          message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }

  @override
  Future<ResponseStatus> changeSectionPosition({
    required List<Section> sections,
    required String groupId,
    required String repertoryId
  }) async {
    try {
    final WriteBatch batch = _database.batch();

      for (int i = 0; i < sections.length; i++) {
        final sectionRef = _database
            .collection('groups/$groupId/repertories/$repertoryId/sections')
            .doc(sections[i].id);
        batch.update(sectionRef, {'position': i + 1});
      }

      await batch.commit();
    
    return ResponseStatus(message: 'Actualizado', hasError: false);
    } on FirebaseException catch (e) {
    return ResponseStatus(message: e.message ?? 'An exeption occurred', hasError: true);
    } catch (e) {
    return ResponseStatus(message: e.toString(), hasError: true);
    }
  }
}
