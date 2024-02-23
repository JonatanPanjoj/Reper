import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/infrastructure/datasources/firebase_section_datasource.dart';
import 'package:reper/infrastructure/repositories/section_repository_impl.dart';

final sectionRepositoryProvider = Provider((ref) {
  return SectionRepositoryImpl(FirebaseSectionDatasource());
});