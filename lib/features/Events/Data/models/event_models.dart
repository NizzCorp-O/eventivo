class EventModel {
  final String id;
  final String name;
  final String createdBy; // login user uid
  final String venue;
  final String address;
  final String date;
  final String startTime;
  final String endTime;
  final String entryFee;
  final String offerPrice;
  final String availableSlot;
  final List<String> imageUrls; // multiple images
  final DateTime createdAt; // event create timestamp

  EventModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.venue,
    required this.address,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.entryFee,
    required this.offerPrice,
    required this.availableSlot,
    required this.imageUrls,
    required this.createdAt,
  });

  /// 🔹 Convert model → Firestore map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "createdBy": createdBy,
      "venue": venue,
      "address": address,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "entryFee": entryFee,
      "offerPrice": offerPrice,
      "availableSlot": availableSlot,
      "imageUrls": imageUrls,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  /// 🔹 Firestore map → Model
  factory EventModel.fromMap(String id, Map<String, dynamic> map) {
    return EventModel(
      id: id,
      name: map['name'] ?? '',
      createdBy: map['createdBy'] ?? '',
      venue: map['venue'] ?? '',
      address: map['address'] ?? '',
      date: map['date'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      entryFee: map['entryFee'] ?? '',
      offerPrice: map['offerPrice'] ?? '',
      availableSlot: map['availableSlot'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Copy with updated values
  EventModel copyWith({
    String? id,
    String? name,
    String? createdBy,
    String? venue,
    String? address,
    String? date,
    String? startTime,
    String? endTime,
    String? entryFee,
    String? offerPrice,
    String? availableSlot,
    List<String>? imageUrls,
    DateTime? createdAt,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      venue: venue ?? this.venue,
      address: address ?? this.address,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      entryFee: entryFee ?? this.entryFee,
      offerPrice: offerPrice ?? this.offerPrice,
      availableSlot: availableSlot ?? this.availableSlot,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// 🔹 Extra getters
extension EventDateTime on EventModel {
  DateTime get startDateTime => DateTime.tryParse("$date $startTime:00") ?? DateTime.now();
  DateTime get endDateTime => DateTime.tryParse("$date $endTime:00") ?? DateTime.now();
}
