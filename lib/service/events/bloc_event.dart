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
  late final String _message;
  String get message => _message;
  late final String _user;
  String get user => _user;


  SendMessage({required String message, required String user}){
    _message = message;
    _user = user;
  }

  @override
  List<Object?> get props => [];
}