import 'package:cloud_firestore/cloud_firestore.dart';

import '../chatCard.dart';

/// Репозиторий для пользователя
class ChatRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Query<Map<String, dynamic>> chat =
      FirebaseFirestore.instance.collection("daaaazzxczqwqe");
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("daaaazzxczqwqe").snapshots();

  /// Получение списка тестов, которые имеют ответы
  void sendChatMessage(
    String message,
    String user,
    DateTime time,
  ) {
    print("send rep");
    FirebaseFirestore.instance
        .collection('daaaazzxczqwqe')
        .add(<String, dynamic>{
      'text': message,
      'user': user,
      'timestamp': time,
    });
  }

  /// Получение списка, прогресс которых больше 0
  Query<ChatCard2> getChatStream() {
    final Query<ChatCard2> chatQuerry = FirebaseFirestore.instance
        .collection('daaaazzxczqwqe')
        .orderBy('timestamp', descending: true)
        .withConverter<ChatCard2>(
          fromFirestore: (snapshot, _) => ChatCard2.fromJson(snapshot.data()!),
          toFirestore: (ChatCard2, _) => ChatCard2.toJson(),
        );
    return chatQuerry;
  }
}

