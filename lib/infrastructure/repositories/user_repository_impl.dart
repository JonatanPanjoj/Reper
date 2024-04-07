import 'package:reper/domain/datasources/user_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<ResponseStatus> validateNickname({
    required String nickname,
  }) {
    return datasource.validateNickname(nickname: nickname);
  }

  @override
  Future<ResponseStatus> createUser({
    required AppUser user,
    required String uid,
  }) {
    return datasource.createUser(user: user, uid: uid);
  }
  
  @override
  Future<ResponseStatus> validateGoogleUser({required String id}) {
    return datasource.validateGoogleUser(id: id);
  }
  
  @override
  Future<AppUser?> getUserById({required String uid}) {
    return datasource.getUserById(uid: uid);
  }
  
  @override
  Future<ResponseStatus> updateUser({required AppUser user}) {
    return datasource.updateUser(user: user);
  }
  
  @override
  Future<ResponseStatus> updateGroup({required String uid, required String groupId}) {
    return datasource.updateGroup(uid: uid, groupId: groupId);
  }
  
  @override
  Stream<AppUser?> streamUser({required String uid}) {
    return datasource.streamUser(uid: uid);
  }
  
  @override
  Stream<List<AppUser>> streamUserFriends({required List<String> friends}) {
    return datasource.streamUserFriends(friends: friends);
  }
}
