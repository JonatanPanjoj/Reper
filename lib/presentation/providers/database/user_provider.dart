import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/repositories/user_repository_impl.dart';
import 'package:reper/presentation/providers/database/repositories/user_repository_provider.dart';

final userProvider = StateNotifierProvider<UserNotifier, AppUser>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);

  return UserNotifier(userRepository: userRepository);
});

class UserNotifier extends StateNotifier<AppUser> {
  final UserRepositoryImpl userRepository;

  UserNotifier({required this.userRepository}) : super(AppUser.empty());

  streamUserInfo(String uid) async {
    // ignore: unused_local_variable
    StreamSubscription<AppUser?>? subscription;
    subscription = userRepository.streamUser(uid: uid).listen((user) {
      if (user != null) {
        state = user;
      }
    });
  }

  Future <ResponseStatus> updateUser(AppUser user, Uint8List? file) async {
    String imageUrl = user.image;
    if (file != null) {
      imageUrl = await uploadImageToStorage(
        fileName: user.uid,
        childName: 'profile_pictures',
        mediaFile: file,
      );
      //TODO:Update state
      return await userRepository.updateUser(user: user.copyWith(image: imageUrl));
    }
    //TODO:Update state
    return await userRepository.updateUser(user: user);
  }
}
