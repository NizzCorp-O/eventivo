class EventModel {
  final String id;
  final String name;
  final String venue;
  final String date;
  final String time;
  final String entryFee;
  final String offerPrice;
  final String availableSlot;
  final List<String> imageUrls; // multiple images

  EventModel({
    required this.id,
    required this.name,
    required this.venue,
    required this.date,
    required this.time,
    required this.entryFee,
    required this.offerPrice,
    required this.availableSlot,
    required this.imageUrls,
  });

  // Firestore-lekku data map aakkunna function
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'venue': venue,
      'date': date,
      'time': time,
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
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      entryFee: map['entryFee'] ?? '',
      offerPrice: map['offerPrice'] ?? '',
      availableSlot: map['availableSlot'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}
