import 'package:reper/domain/entities/entities.dart';

abstract class SectionRepository {
  Future<ResponseStatus> createSection({
    required String groupId,
    required String repertoryId,
    required Section section,
  });

  Stream<List<Section>> streamSections({
    required String groupId,
    required String repertoryId,
  });
}
