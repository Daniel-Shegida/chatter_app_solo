import 'package:chatter_solo_serfers/chatCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Состояния для дейстий пользователя
abstract class BaseChatState extends Equatable {}

/// Состояние инициализации
class InitialState extends BaseChatState {
  @override
  List<Object?> get props => [];
}

/// Состояние, которое хранит в себе затреканные даты
class ChatStreamState extends BaseChatState {
  ChatStreamState( {
    required this.chatStream
  });

  final Query<ChatCard2> chatStream;



  @override
  List<Object?> get props => [];
}

// /// Состояние показа тестов
// class ShowTests extends ProfileState {
//   ShowTests({required this.tests});
//
//   final List<Test> tests;
//
//   @override
//   List<Object?> get props => [tests];
// }
//
// /// Состояние показа топиков
// class ShowTopics extends ProfileState {
//   ShowTopics({required this.topics});
//
//   final List<Topic> topics;
//
//   @override
//   List<Object?> get props => [topics];
// }