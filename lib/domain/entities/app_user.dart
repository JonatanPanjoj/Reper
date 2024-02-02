import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final Timestamp joinedAt;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.joinedAt
  });

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    Timestamp? joinedAt
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'joined_at': joinedAt
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      joinedAt: json['joined_at'],

    );
  }

  factory AppUser.empty() {
    return AppUser(
      uid: '',
      name: '',
      email: '',
      joinedAt: Timestamp.now()
    );
  }
}
