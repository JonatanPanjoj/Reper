import 'package:reper/domain/entities/entities.dart';

abstract class SectionDatasource {
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

  Future<ResponseStatus> updateSection({
    required Section section,
    required String groupId,
    required String repertoryId,
  });

  Future<ResponseStatus> changeSectionPosition({
    required List<Section> sections,
    required String groupId,
    required String repertoryId,
  });
}
