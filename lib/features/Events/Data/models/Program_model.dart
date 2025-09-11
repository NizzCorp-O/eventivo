class ProgramModel {
  final String id;
  final String title;
  final String description;

  final String time;

  ProgramModel({
    required this.time,
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "description": description, "time": time};
  }

  factory ProgramModel.fromMap(String id, Map<String, dynamic> map) {
    return ProgramModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      time: map['time'] ?? '',
    );
  }

  ProgramModel copyWith({
    String? id,
    String? title,
    String? description,
    String? time,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      title: title ?? this.title,
      time: title ?? this.time,
      description: description ?? this.description,
    );
  }
}
