

import 'package:chatter_solo_serfers/message.dart';
import 'package:chatter_solo_serfers/service/bloc.dart';
import 'package:chatter_solo_serfers/service/events/bloc_event.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:chatter_solo_serfers/ui/chat_screen.dart';
import 'package:elementary/elementary.dart';

/// Model for [ChatScreen]
class ChatModel extends ElementaryModel {
  // final CountryRepository _countryRepository;

  /// Create an instance [ChatModel].
  ChatModel(
      this._chatBloc,
      // ErrorHandler errorHandler,
      ) : super(
      // errorHandler: errorHandler
  );




  final ProfileBloc _chatBloc;
  /// Stream to track the state of the [ProfileBloc].
  Stream<BaseChatState> get chatStateStream => _chatBloc.stream;

  /// Gives the current state.
  BaseChatState get currentState => _chatBloc.state;

  Stream? steam;

  /// Method for update info about user.
  void sendMessage(Message message) {
    print("sendModel");
    _chatBloc.add(SendMessage(message: message));
  }

  /// Method for save profile.
  void prepareChat() {
    _chatBloc.add(GetChatStream());
  }



// /// Return iterable countries.
  // Future<Iterable<Country>> loadCountries() async {
  //   try {
  //     // final res = await _countryRepository.getAllCountries();
  //     // return res;
  //   } on Exception catch (e) {
  //     handleError(e);
  //     rethrow;
  //   }
  // }
}