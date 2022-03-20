import 'package:chatter_solo_serfers/common/classes/message.dart';
import 'package:equatable/equatable.dart';

/// Basic class for chat events
abstract class ChatEvent extends Equatable {}

/// event of stream preparation
class GetChatStream extends ChatEvent {
  @override
  List<Object?> get props => [];
}

/// event of sending message
class SendMessage extends ChatEvent {
  late final Message _message;

  Message get message => _message;

  SendMessage({required Message message}) {
    _message = message;
  }

  @override
  List<Object?> get props => [];
}
