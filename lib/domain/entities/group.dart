class Group {
  final String id;
  final String name;
  final String image;
  final List<String> reps;

  Group(
      {required this.id,
      required this.name,
      required this.image,
      required this.reps});

  Group copyWith({
    String? id,
    String? name,
    String? image,
    final List<String>? reps,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      reps: reps ?? this.reps,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'reps': reps,
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      reps: List<String>.from(
        json['reps'] ?? [],
      ),
    );
  }

  factory Group.empty() {
    return Group(id: '', name: '', image: '', reps:[]);
  }
}
