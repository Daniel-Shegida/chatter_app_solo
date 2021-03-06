import 'package:chatter_solo_serfers/assets/strings/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/classes/data_chat_card.dart';

/// repository for chat
class ChatRepository {
  /// send message to firestore
  void sendChatMessage(
    String message,
    String user,
    DateTime time,
  ) {
    FirebaseFirestore.instance
        .collection(Strings.collectionName)
        .add(<String, dynamic>{
      'text': message,
      'user': user,
      'timestamp': time,
    });
  }

  /// get query with descending order of chat
  Query<DataChatCard> getChatStream() {
    final Query<DataChatCard> chatQuerry = FirebaseFirestore.instance
        .collection(Strings.collectionName)
        .orderBy('timestamp', descending: true)
        .withConverter<DataChatCard>(
          fromFirestore: (snapshot, _) =>
              DataChatCard.fromJson(snapshot.data()!),
          toFirestore: (dataChatCard, _) => dataChatCard.toJson(),
        );
    return chatQuerry;
  }
}
