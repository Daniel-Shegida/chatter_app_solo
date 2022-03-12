import 'package:cloud_firestore/cloud_firestore.dart';

/// Репозиторий для пользователя
class ChatRepository {
  Query<Map<String, dynamic>> chat =
      FirebaseFirestore.instance.collection("daaaazzxczqwqe").orderBy("time");

  // ChatRepository({
  //   required this.profileApi,
  //   required this.userStorage,
  // });

  // final UserStorage userStorage;
  // final ProfileApi profileApi;

  /// Получение списка тестов, которые имеют ответы
  void sendChatMessage(
    String message,
    String user,
      DateTime time,
  ) {
    FirebaseFirestore.instance.collection('guestbook').add(<String, dynamic>{
      'text': message,
      'user': user,
      'timestamp': time,
    });
  }

  /// Получение списка, прогресс которых больше 0
  Stream? getChatStream() {
    final Stream? topicResponse = chat.snapshots();
    return topicResponse;
  }
}
