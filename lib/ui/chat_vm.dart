import 'dart:async';

import 'package:chatter_solo_serfers/chatCard.dart';
import 'package:chatter_solo_serfers/message.dart';
import 'package:chatter_solo_serfers/service/bloc.dart';
import 'package:chatter_solo_serfers/service/flutterFireRep.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:chatter_solo_serfers/ui/chat_model.dart';
import 'package:chatter_solo_serfers/ui/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';


/// Factory for [CountryListScreenWidgetModel]
ChatVM ChatVMFactory(BuildContext context,) {
  // final model = context.read<ChatModel>();
  ChatRepository test = ChatRepository();
  ProfileBloc test2 = ProfileBloc(chatRepository: test);
  final model = ChatModel(test2);

  // final theme = context.read<ThemeWrapper>();
  return ChatVM(
    model,
    // theme
  );
}


/// Widget Model for [CountryListScreen]
class ChatVM extends WidgetModel<ChatScreen, ChatModel>
    implements IChatWidgetModel {

  ChatVM(ChatModel model,
      // this._themeWrapper,
      ) : super(model);

  late final StreamSubscription<BaseChatState> _stateStatusSubscription;
  final _controller = TextEditingController();
  String _username = 'anon';
  bool _isReady = false;
  late StreamSubscription sub;
  int testint = 0;

  // final testingStream  = FirebaseFirestore.instance.collection('daaaazzxczqwqe').withConverter<ChatCard2>(
  //   fromFirestore: (snapshot, _) => ChatCard2.fromJson(snapshot.data()!),
  //   toFirestore: (ChatCard2, _) => ChatCard2.toJson(),
  // );


  @override
  TextEditingController get controller => _controller;

  @override
  Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("daaaazzxczqwqe").snapshots();

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

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _stateStatusSubscription = model.chatStateStream.listen(_updateState);
    // _controller.addListener(
    //     // _aboutMeTextChanged
    // );
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
      stream = state.chatStream;
      print("prepare");
      print(somePropertyWithIntegerValue2.value);
      print(_isReady);
      _isReady = true;
      print(_isReady);
      print(stream);
      somePropertyWithIntegerValue2.accept(_isReady);
      print("we change 2 val to true");
      // stream.listen((event)  {
      //   print("event");
      //   print(event);
      //   print("event");
      //
      // },
      // );
      sub = stream.listen((event) {
        print(event.docs.length);
        print(event.docs.last.get("text"));
        testint = event.docs.length;
      });


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

// void _aboutMeTextChanged() {
//   if (_initialInfo != _controller.text) {
//     _buttonState.accept(AboutMeScreenStrings.saveButtonTitle);
//     model.updateAboutMe(_controller.text);
//   } else {
//     _buttonState.accept(AboutMeScreenStrings.okButtonTitle);
//     model.cancelEditing();
//   }
// }

@override
void onErrorHandle(Object error) {
  // super.onErrorHandle(error);

}



/// Interface of [ChatWm]
abstract class IChatWidgetModel extends IWidgetModel {
  /// Text editing controller for [TextFormField].
  TextEditingController get controller;

  Stream<QuerySnapshot>? get stream;

  bool get chatMode;

  String get userName;

  bool get isReady;

  // var get testingStream;

  late final StateNotifier<bool> somePropertyWithIntegerValue;
  late final StateNotifier<bool> somePropertyWithIntegerValue2;



  /// Function to save user info in [Profile].
  void updateAboutMe();

  void sendMessage();

  void changeMode();



// ListenableState<EntityState<Iterable<Country>>> get countryListState;
//
// TextStyle get countryNameStyle;
}