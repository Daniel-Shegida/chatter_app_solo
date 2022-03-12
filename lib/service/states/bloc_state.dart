import 'package:equatable/equatable.dart';

/// Состояния для дейстий пользователя
abstract class ChatState extends Equatable {}

/// Состояние инициализации
class InitialState extends ChatState {
  @override
  List<Object?> get props => [];
}

/// Состояние, которое хранит в себе затреканные даты
class ChatStreamState extends ChatState {
  ChatStreamState( {
    required this.chatStream
  });

  final Stream? chatStream;

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