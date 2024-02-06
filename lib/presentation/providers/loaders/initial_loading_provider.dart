import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(userProvider).uid.isEmpty;

  if (step1) return true;

  return false; // terminamos de cargar
});
