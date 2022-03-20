
/// class for DataChatCard in flutter fire ui lib widget (maybe delete later and
/// create list (not query) chat widget)
class DataChatCard {

  /// Create an instance [DataChatCard].
  DataChatCard({required this.text, required this.user, required this.timestamp});


  DataChatCard.fromJson(Map<String, Object?> json)
      : this(
    text: json['text']! as String,
    user: json['user']! as String,
    timestamp: json['timestamp']! as DateTime,
  );

  final String text;
  final String user;
  final DateTime timestamp;

  Map<String, Object?> toJson() {
    return {
      'text': text,
      'user': user,
      'timestamp': timestamp,
    };
  }
}
