import 'package:reper/domain/entities/entities.dart';

abstract class NotificationRepository{

  Future<ResponseStatus> getNotification({required String receiverId});

  Future<ResponseStatus> createNotification({required AppNotification notification, required String nickName});

  Future<ResponseStatus> validateNotification({required String receiverId});

  Stream<List<AppNotification>> streamUserNotifications();

  Future<ResponseStatus> changeRequestStatus({required AppNotification notification});
}