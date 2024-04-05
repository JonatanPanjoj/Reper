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
  
  @override
  Future<ResponseStatus> deleteSection({required String groupId, required String repertoryId, required String sectionId}) {
    return datasource.deleteSection(groupId: groupId, repertoryId: repertoryId, sectionId: sectionId);
  } 
  
  @override
  Future<ResponseStatus> updateSection({required Section section, required String groupId, required String repertoryId}) {
    return datasource.updateSection(section: section, groupId: groupId, repertoryId: repertoryId);
  }
  
  @override
  Future<ResponseStatus> changeSectionPosition({required List<Section> sections, required String groupId, required String repertoryId}) {
    return datasource.changeSectionPosition(sections: sections, groupId: groupId, repertoryId: repertoryId);
  }
  
  
}
