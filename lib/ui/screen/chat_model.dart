import 'package:chatter_solo_serfers/common/classes/message.dart';
import 'package:chatter_solo_serfers/service/bloc.dart';
import 'package:chatter_solo_serfers/service/events/bloc_event.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:elementary/elementary.dart';

/// Model for [ChatScreen]
class ChatModel extends ElementaryModel {
  // final CountryRepository _countryRepository;

  /// Create an instance [ChatModel].
  ChatModel(
    this._chatBloc,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  final ProfileBloc _chatBloc;

  /// Gives the current state.
  BaseChatState get currentState => _chatBloc.state;

  /// Stream to track the state of the [ProfileBloc].
  Stream<BaseChatState> get profileStateStream => _chatBloc.stream;

  /// Method for sending message
  void sendMessage(Message message) {
    _chatBloc.add(SendMessage(message: message));
  }

  /// Method for getting started stream
  void prepareChat() {
    _chatBloc.add(GetChatStream());
  }
}
