class ChatModels {
  final String text;
  final String senderName;
  final String time;

  ChatModels({
    required this.text,

    required this.senderName,
    required this.time,
  });

  factory ChatModels.fromJson(Map<String, dynamic> json) {
    return ChatModels(
      text: json['text'],

      senderName: json['senderName'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'senderName': senderName, 'time': time};
  }
}
