class ProgramModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final int order;

  ProgramModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.order,
  });

  ProgramModel copyWith({
    String? id,
    String? title,
    String? description,
    String? time,
    int? order,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "time": time,
      "order": order,
    };
  }

  factory ProgramModel.fromMap(String id, Map<String, dynamic> map) {
    return ProgramModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      time: map['time'] ?? '',
      order: map['order'] ?? 0,
    );
  }
}


//   ProgramModel copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? time,
//   }) {
//     return ProgramModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       time: title ?? this.time,
//       description: description ?? this.description,
//     );
//   }
// }
