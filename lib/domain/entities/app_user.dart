import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String? googleId;
  final String name;
  final String email;
  final Timestamp joinedAt;

  AppUser({
    required this.uid,
    this.googleId,
    required this.name,
    required this.email,
    required this.joinedAt,
  });

  AppUser copyWith({
    String? uid,
    String? googleId,
    String? name,
    String? email,
    Timestamp? joinedAt,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      joinedAt: joinedAt ?? this.joinedAt,
      googleId: googleId ?? this.googleId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'joined_at': joinedAt,
      'google_id': googleId,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      joinedAt: json['joined_at'],
      googleId: json['google_id'],
    );
  }

  factory AppUser.empty() {
    return AppUser(
        uid: '', googleId: '', name: '', email: '', joinedAt: Timestamp.now());
  }
}
