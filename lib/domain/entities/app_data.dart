class AppData {
  final String version;

  AppData({required this.version});

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
    };
  }

  AppData copyWith({String? version}) {
    return AppData(
      version: version ?? this.version,
    );
  }
}
