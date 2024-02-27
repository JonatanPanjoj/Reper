import 'package:reper/domain/entities/entities.dart';

abstract class SectionRepository {
  Future<ResponseStatus> createSection({
    required String groupId,
    required String repertoryId,
    required Section section,
  });

  Future<ResponseStatus> deleteSection({
    required String groupId,
    required String repertoryId,
    required String sectionId,
  });

  Stream<List<Section>> streamSections({
    required String groupId,
    required String repertoryId,
  });
}
