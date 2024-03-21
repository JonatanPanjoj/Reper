import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType{
  group,
  friend,
  admin;

  String get value{
    switch(this){
      case NotificationType.group:
        return 'group';
      case NotificationType.friend:
        return 'friend';
      default:
        return 'admin';
    }
  }

  static NotificationType fromString(String value) {
    switch (value) {
      case 'group':
        return NotificationType.group;
      case 'friend':
        return NotificationType.friend;
      default:
        return NotificationType.admin;
    }
  }
}

enum NotificationStatus{
  accepted,
  rejected,
  waiting;

  String get value{
    switch(this){
      case NotificationStatus.accepted:
        return 'accepted';
      case NotificationStatus.rejected:
        return 'rejected';
      default:
        return 'waiting';
    }
  }

  static NotificationStatus fromString(String value) {
    switch (value) {
      case 'accepted':
        return NotificationStatus.accepted;
      case 'rejected':
        return NotificationStatus.rejected;
      default:
        return NotificationStatus.waiting;
    }
  }
}

class AppNotification {
  final String id;
  final NotificationType type;
  final String senderId;
  final String receiverId;
  final Timestamp sentAt;
  final NotificationStatus status;
  final String? message;
  final String? groupId;

  AppNotification({
    required this.id,
    required this.type,
    required this.senderId,
    required this.receiverId,
    required this.sentAt,
    this.status = NotificationStatus.waiting,
    this.message,
    this.groupId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'sent_at': sentAt,
      'message': message,
      'group_id': groupId,
      'status': status.value,
    };
  }

  factory AppNotification.fromJson(Map<String, dynamic> json){
    return AppNotification(
      id: json['id'] ?? '',
      type: NotificationType.fromString(json['type'] ?? ''),
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      sentAt: json['sent_at'],
      message: json['message'] ?? '',
      groupId: json['group_id'] ?? '',
      status: NotificationStatus.fromString(json['status'] ?? ''),
    );
  }

  AppNotification copyWith({
    String? id,
    NotificationType? type,
    String? senderId,
    String? receiverId,
    Timestamp? sentAt,
    String? message,
    String? groupId,
    NotificationStatus? status
  }){
    return AppNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      sentAt: sentAt ?? this.sentAt,
      message: message ?? this.message,
      groupId: groupId ?? this.groupId,
      status: status ?? this.status
    );
  }
}
