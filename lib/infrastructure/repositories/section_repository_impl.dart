import 'package:reper/domain/datasources/section_datasource.dart';
import 'package:reper/domain/entities/section.dart';
import 'package:reper/domain/entities/shared/response_status.dart';
import 'package:reper/domain/repositories/section_repository.dart';

class SectionRepositoryImpl extends SectionRepository {
  SectionDatasource datasource;

  SectionRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> createSection({
    required String groupId,
    required String repertoryId,
    required Section section,
  }) {
    return datasource.createSection(
        groupId: groupId, repertoryId: repertoryId, section: section);
  }
  
  @override
  Stream<List<Section>> streamSections({required String groupId, required String repertoryId}) {
    return datasource.streamSections(groupId: groupId, repertoryId: repertoryId);
  }
}
