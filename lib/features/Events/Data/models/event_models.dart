class EventModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final double entryFee;
  final double offerPrice;
  final List<String> imageUrl; // <-- New field (URL from Firebase Storage)

  EventModel(this.time, this.entryFee, this.offerPrice, {
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'location': location,
      'imageUrl': imageUrl, 
      "time": time,
      "offerPrice":offerPrice,
      "entryFee": entryFee
      // Save URL as String
    };
  }

  // Create from Map
  // factory EventModel.fromMap(Map<String, dynamic> map) {
  //   return EventModel(
     
  //     id: map['id'] ?? '',
  //     title: map['title'] ?? '',
  //     date: map['date'] ?? '',
  //     location: map['location'] ?? '',
  //     imageUrl: List<String>.from(map['imageUrls'] ?? [],
  //     ),
  //   );
  // }
}
