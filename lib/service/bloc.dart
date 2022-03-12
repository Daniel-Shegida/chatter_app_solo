

import 'package:chatter_solo_serfers/service/events/bloc_event.dart';
import 'package:chatter_solo_serfers/service/flutterFireRep.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Блок сервисного слоя для
class ProfileBloc extends Bloc<ChatEvent, ChatState> {
  ProfileBloc({
    required this.chatRepository,
  }) : super(InitialState()) {
    /// Запрос затреканных дат и кол-ва дней пользователя
    on<GetChatStream>((event, emit) async {
      try {
        final Stream? chatStream = chatRepository.getChatStream();

        emit(ChatStreamState(
          chatStream: chatStream,
        ));
      } catch (_) {
        // TODO: бработать ошибку
      }
    });

    /// Запрос получения тестов
    on<SendMessage>((event, emit) async {
      try {
        chatRepository.sendChatMessage(event.message, event.user, DateTime.now());
      } catch(_) {
        // TODO: обработать ошибку
      }
    });
  }

  final ChatRepository chatRepository;
  // final DateTrackService dateTrackService;
}