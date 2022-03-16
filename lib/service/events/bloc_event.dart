import 'package:chatter_solo_serfers/message.dart';
import 'package:equatable/equatable.dart';

/// Базовый класс для событий пользователя
abstract class ChatEvent extends Equatable {}


/// Событие получения тестов
class GetChatStream extends ChatEvent {
  @override
  List<Object?> get props => [];
}

/// Событие получения топиков
class SendMessage extends ChatEvent {
  late final Message _message;
  Message get message => _message;



  SendMessage({required Message message}){
    _message = message;
  }

  @override
  List<Object?> get props => [];
}