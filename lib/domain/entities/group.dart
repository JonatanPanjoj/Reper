class Group {
  final String id;
  final String name;
  final String image;

  Group({
    required this.id,
    required this.name,
    required this.image,
  });

  Group copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  factory Group.empty() {
    return Group(id: '', name: '', image: '');
  }
}
