import 'package:chatter_solo_serfers/common/classes/data_chat_card.dart';
import 'package:chatter_solo_serfers/service/events/bloc_event.dart';
import 'package:chatter_solo_serfers/service/rep/flutterFireRep.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc of service layer
class ProfileBloc extends Bloc<ChatEvent, BaseChatState> {
  ProfileBloc({
    required this.chatRepository,
  }) : super(InitialState()) {
    /// request of chat stream
    on<GetChatStream>((event, emit) async {
      try {
        final Query<DataChatCard> chatStream = chatRepository.getChatStream();

        emit(ChatStreamState(
          chatStream: chatStream,
        ));
      } catch (_) {
        // TODO: бработать ошибку
      }
    });

    /// request of sending message
    on<SendMessage>((event, emit) async {
      try {
        chatRepository.sendChatMessage(event.message.textOfMessage,
            event.message.author, event.message.time);
      } catch (_) {
        // TODO: обработать ошибку
      }
    });
  }

  final ChatRepository chatRepository;
}
