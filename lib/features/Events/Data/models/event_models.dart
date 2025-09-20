class EventModel {
  final String id;
  final String name;
  final String venue;
  final String Address;
  final String date;
  final String starttime;
  final String endtime;
  final String entryFee;
  final String offerPrice;
  final String availableSlot;
  final List<String> imageUrls; // multiple images

  EventModel({
    required this.id,
    required this.name,
    required this.venue,
    required this.Address,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.entryFee,
    required this.offerPrice,
    required this.availableSlot,
    required this.imageUrls,
  });

  // Firestore-lekku data map aakkunna function
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'name': name,
      'venue': venue,
      "address": Address,
      'date': date,
      'starttime': starttime,
      "endtime": endtime,
      'entryFee': entryFee,
      'offerPrice': offerPrice,
      'availableSlot': availableSlot,
      'imageUrls': imageUrls,
    };
  }

  // Firestore-il ninnu data map cheythu model aakkunna function
  factory EventModel.fromMap(String id, Map<String, dynamic> map) {
    return EventModel(
      id: id,
      name: map['name'] ?? '',
      venue: map['venue'] ?? '',
      Address: map['address'] ?? '',
      date: map['date'] ?? '',
      starttime: map['starttime'] ?? '',
      endtime: map['endtime'] ?? '',
      entryFee: map['entryFee'] ?? '',
      offerPrice: map['offerPrice'] ?? '',
      availableSlot: map['availableSlot'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
  EventModel copyWith({
    String? id,
    String? name,
    String? venue,
    String? Address,
    String? date,
    String? starttime,
    String? endtime,
    String? entryFee,
    String? offerPrice,
    String? availableSlot,
    List<String>? imageUrls,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      venue: venue ?? this.venue,
      Address: Address ?? this.Address,
      date: date ?? this.date,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      entryFee: entryFee ?? this.entryFee,
      offerPrice: offerPrice ?? this.offerPrice,
      availableSlot: availableSlot ?? this.availableSlot,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
