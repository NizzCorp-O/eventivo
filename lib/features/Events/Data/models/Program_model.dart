



class ProgramModel {
  final String id;
  final String title;
  final String description;
  final String startTime; 
  final String endTime;  // previously 'time'
    // auto calculate
  final String duration;    // user input duration
  final int order;

  ProgramModel( {
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
   required this.endTime,
  
    required this.duration,
    required this.order,
  });

  ProgramModel copyWith({
    String? id,
    String? title,
    String? description,
    String? startTime,
    String? endTime,
    
    String? duration,
    int? order,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    

  
      duration: duration ?? this.duration,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "startTime": startTime,
      "endTime":endTime,
      "duration": duration,
      "order": order,
    };
  }

  factory ProgramModel.fromMap(String id, Map<String, dynamic> map) {
    return ProgramModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startTime: map['startTime'] ?? "",
      endTime: map['endTime'] ?? "",

      
      duration: map['duration'] ?? "",
      order: map['order'] ?? 0,
    );
  }
}


