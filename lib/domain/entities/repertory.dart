class Repertory {
  final String id;
  final String groupId;
  final String name;
  final String image;
  final List<String> sections;

  Repertory({
    required this.id,
    required this.groupId,
    required this.name,
    required this.image,
    required this.sections
  });

  Repertory copyWith({
    String? id,
    String? groupId,
    String? name,
    String? image,
    List<String>? sections,
  }) {
    return Repertory(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      image: image ?? this.image,
      sections: sections ?? this.sections
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'name': name,
      'image': image,
      'sections': sections
    };
  }

  factory Repertory.fromJson(Map<String, dynamic> json) {
    return Repertory(
      id: json['id'],
      groupId: json['group_id'],
      name: json['name'],
      image: json['image'],
      sections: List<String>.from(
        json['sections'] ?? [],
      ),
    );
  }

  factory Repertory.empty() {
    return Repertory(
      id: '',
      groupId: '',
      name: '',
      image: '',
      sections: []
    );
  }
}
