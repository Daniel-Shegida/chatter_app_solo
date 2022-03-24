import 'package:chatter_solo_serfers/common/classes/data_chat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// basic state of chat
abstract class BaseChatState extends Equatable {}

/// initializing state
class InitialState extends BaseChatState {
  @override
  List<Object?> get props => [];
}

/// state with chat stream (query)
class ChatStreamState extends BaseChatState {
  ChatStreamState({required this.chatStream});

  final Query<DataChatCard> chatStream;

  @override
  List<Object?> get props => [chatStream];
}
