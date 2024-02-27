class Group {
  final String id;
  final String name;
  final String image;
  final List<String> repertories;

  Group(
      {required this.id,
      required this.name,
      required this.image,
      required this.repertories});

  Group copyWith({
    String? id,
    String? name,
    String? image,
    final List<String>? repertories,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      repertories: repertories ?? this.repertories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'repertories': repertories,
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      repertories: List<String>.from(
        json['repertories'] ?? [],
      ),
    );
  }

  factory Group.empty() {
    return Group(id: '', name: '', image: '', repertories:[]);
  }
}
