import 'package:reper/domain/entities/section.dart';

class Repertory {
  final String id;
  final String groupId;
  final String name;
  final String image;
  final List<Section> sections;

  Repertory({
    required this.id,
    required this.groupId,
    required this.name,
    required this.image,
    required this.sections,
  });

  Repertory copyWith({
    String? id,
    String? groupId,
    String? name,
    String? image,
    List<Section>? sections,
  }) {
    return Repertory(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      image: image ?? this.image,
      sections: sections ?? this.sections,
    );
  }

Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'name': name,
      'image': image,
      'sections': sections.map((section) => section.toJson()).toList(),
    };
  }


factory Repertory.fromJson(Map<String, dynamic> json) {
    return Repertory(
      id: json['id'],
      groupId: json['group_id'],
      name: json['name'],
      image: json['image'],
      sections: (json['sections'] as List<dynamic>)
          .map((sectionJson) => Section.fromJson(sectionJson))
          .toList(),
    );
  }

  factory Repertory.empty() {
    return Repertory(
      id: '',
      groupId: '',
      name: '',
      image: '',
      sections: [],
    );
  }

}
