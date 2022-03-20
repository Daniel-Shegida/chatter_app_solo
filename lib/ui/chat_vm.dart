import 'dart:async';

import 'package:chatter_solo_serfers/app/di/app_scope.dart';
import 'package:chatter_solo_serfers/chatCard.dart';
import 'package:chatter_solo_serfers/message.dart';
import 'package:chatter_solo_serfers/service/bloc.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:chatter_solo_serfers/ui/chat_model.dart';
import 'package:chatter_solo_serfers/ui/chat_screen.dart';
import 'package:chatter_solo_serfers/utils/dialog_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Factory for [CountryListScreenWidgetModel]
ChatVM ChatVMFactory(BuildContext context,) {
  final appDependencies = context.read<IAppScope>();
  final model = ChatModel(
    appDependencies.profileBloc,
    appDependencies.errorHandler,
  );
  final dialogController = appDependencies.dialogController;
  return ChatVM(
    model: model,
    dialogController: dialogController,
  );
}


/// Widget Model for [CountryListScreen]
class ChatVM extends WidgetModel<ChatScreen, ChatModel>
    implements IChatWidgetModel {

  // ChatVM(ChatModel model,
  //     // this._themeWrapper,
  //     ) : super(model);

  /// Controller for show [SnackBar].
  final DialogController dialogController;

  late final StreamSubscription<BaseChatState> _stateStatusSubscription;
  final _controller = TextEditingController();
  String _username = 'anon';
  bool _isReady = false;
  int testint = 0;



  // final testingStream  = FirebaseFirestore.instance.collection('daaaazzxczqwqe').withConverter<ChatCard2>(
  //   fromFirestore: (snapshot, _) => ChatCard2.fromJson(snapshot.data()!),
  //   toFirestore: (ChatCard2, _) => ChatCard2.toJson(),
  // );


  @override
  TextEditingController get controller => _controller;

  @override
  late Query<ChatCard2> stream ;

  @override
  bool  get isReady => _isReady;

  @override
  // TODO: implement userName
  String get userName => _username;

  @override
  bool chatMode = false;

  @override
  StateNotifier<bool> somePropertyWithIntegerValue = StateNotifier<bool>();

  @override
  StateNotifier<bool> somePropertyWithIntegerValue2 = StateNotifier<bool>();

  /// Create an instance [AboutMeScreenWidgetModel].
  ChatVM({
    required ChatModel model,
    required this.dialogController,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    // _controller.addListener(
    //     // _aboutMeTextChanged
    // );
    _stateStatusSubscription = model.profileStateStream.listen(_updateState);
    _getChatStream();
    // sub = stream.listen((event) {
    //   print(event.docs.length);
    //   print(event.docs.last.get("text"));
    //   testint = event.docs.length;
    // });
  }

  void _getChatStream() {
    model.prepareChat();
  }

  @override
  void dispose() {
    _controller
    // ..removeListener(_aboutMeTextChanged)
      ..dispose();
    _stateStatusSubscription.cancel();
    // _buttonState.dispose();
    // _saveEntityState.dispose();
    super.dispose();
  }

  void _updateState(BaseChatState state) {
    if (state is ChatStreamState) {
      print("getChat");
      _isReady = true;
      stream = state.chatStream;
      somePropertyWithIntegerValue2.accept(_isReady);

    }
    // else if (state is ProfileSavedSuccessfullyState) {
    //   coordinator.popUntilRoot();
    // }
  }


  @override
  void sendMessage() {
    print("send");
    model.sendMessage(Message(controller.text, userName, DateTime.now()));
  }

  @override
  void updateAboutMe() {
    print("change");
    _username = controller.text;

    /// todo: доделать бд с юзернеймом
  }

  @override
  void changeMode() {
    String test = controller.text;
    controller.clear();
    if (test.trim() =="") {
      print("its empty");
      print(test);
      print("its empty");

    }
    else {
      print("its not empty");
      print(test);
      print("its not empty");

    }
    chatMode = !chatMode;
    somePropertyWithIntegerValue.accept(chatMode);
    print("and what");
    print(chatMode);
    _username = chatMode.toString();
    print(userName);
    print(stream);

    print(testint);
    FirebaseFirestore.instance
        .collection('daaaazzxczqwqe')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["text"]);
      });
    });

    /// todo: доделать бд с юзернеймом
  }


}

@override
void onErrorHandle(Object error) {
  // super.onErrorHandle(error);

}



/// Interface of [ChatWm]
abstract class IChatWidgetModel extends IWidgetModel {
  /// Text editing controller for [TextFormField].
  TextEditingController get controller;

  Query<ChatCard2> get stream;

  bool get chatMode;

  String get userName;

  bool get isReady;


  late final StateNotifier<bool> somePropertyWithIntegerValue;
  late final StateNotifier<bool> somePropertyWithIntegerValue2;



  /// Function to save user info in [Profile].
  void updateAboutMe();

  void sendMessage();

  void changeMode();

}