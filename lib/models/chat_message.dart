class ChatMessage {
  final String id;
  final String sender;
  final String text;
  final String modelName;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.modelName,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender,
    "text": text,
    "modelName": modelName,
    "timestamp": timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json["id"],
    sender: json["sender"],
    text: json["text"],
    modelName: json["modelName"],
    timestamp: DateTime.parse(json["timestamp"]),
  );
}
