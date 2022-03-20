import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCard2 {
  ChatCard2({required this.text, required this.user, required this.timestamp});

  ChatCard2.fromJson(Map<String, Object?> json)
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

final moviesCollection = FirebaseFirestore.instance.collection('daaaazzxczqwqe').orderBy('timestamp', descending: true).withConverter<ChatCard2>(
  fromFirestore: (snapshot, _) => ChatCard2.fromJson(snapshot.data()!),
  toFirestore: (ChatCard2, _) => ChatCard2.toJson(),
);