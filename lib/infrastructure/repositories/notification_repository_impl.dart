
import 'package:reper/domain/datasources/notification_datasource.dart';
import 'package:reper/domain/entities/app_notification.dart';
import 'package:reper/domain/entities/shared/response_status.dart';
import 'package:reper/domain/repositories/notification_repository.dart';

class NotificationRespositoryImpl extends NotificationRepository{

  NotificationDatasource datasource;

  NotificationRespositoryImpl(this.datasource);
  
  @override
  Future<ResponseStatus> createNotification({required AppNotification notification, required String nickName}) {
    return datasource.createNotification(notification: notification, nickName: nickName); 
  }

  @override
  Future<ResponseStatus> getNotification({required String receiverId}) {
    return datasource.getNotification(receiverId: receiverId);
  }

  @override
  Future<ResponseStatus> validateNotification({required String receiverId}){
    return datasource.validateNotification(receiverId: receiverId);
  }
}