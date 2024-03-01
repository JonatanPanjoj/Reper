class Group {
  final String id;
  final String name;
  final String image;
  final List<String> repertories;
  final List<String>? users;

  Group(
      {required this.id,
      required this.name,
      required this.image,
      required this.repertories,
      this.users});

  Group copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? repertories,
    List<String>? users,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      repertories: repertories ?? this.repertories,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'repertories': repertories,
      'users': users,
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
      users: List<String>.from(
        json['users'] ?? [],
      ),
    );
  }

  factory Group.empty() {
    return Group(
      id: '',
      name: '',
      image: '',
      repertories: [],
      users: [],
    );
  }
}
