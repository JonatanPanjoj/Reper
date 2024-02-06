import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/repositories/user_repository_impl.dart';
import 'package:reper/presentation/providers/database/user_repository_provider.dart';

final userProvider = StateNotifierProvider <UserNotifier,AppUser> ((ref) {

  final userRepository = ref.watch(userRepositoryProvider);

  return UserNotifier(userRepository: userRepository);
});

class UserNotifier extends StateNotifier <AppUser> {

  final UserRepositoryImpl userRepository;

  UserNotifier({required this.userRepository}) : super(AppUser.empty());


  loadUserInfo(String uid) async {
    final user = await userRepository.getUserById(uid: uid);
    if (user != null){
      state = user;
    }
  }

}