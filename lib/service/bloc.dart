

import 'package:chatter_solo_serfers/ui/widget/chatCard.dart';
import 'package:chatter_solo_serfers/service/events/bloc_event.dart';
import 'package:chatter_solo_serfers/service/rep/flutterFireRep.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Блок сервисного слоя для
class ProfileBloc extends Bloc<ChatEvent, BaseChatState> {
  ProfileBloc({
    required this.chatRepository,
  }) : super(InitialState()) {
    /// Запрос затреканных дат и кол-ва дней пользователя
    on<GetChatStream>((event, emit) async {
      try {
        final Query<ChatCard2> chatStream = chatRepository.getChatStream();

        emit(ChatStreamState(
          chatStream: chatStream,
        ));
      } catch (_) {
        // TODO: бработать ошибку
      }
    });

    /// Запрос получения тестов
    on<SendMessage>((event, emit) async {
      print("send bloc");
      try {
        chatRepository.sendChatMessage(event.message.textOfMessage, event.message.author, event.message.time);
      } catch(_) {
        // TODO: обработать ошибку
      }
    });
  }

  final ChatRepository chatRepository;
  // final DateTrackService dateTrackService;
}