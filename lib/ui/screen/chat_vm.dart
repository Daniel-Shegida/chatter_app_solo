import 'dart:async';
import 'package:chatter_solo_serfers/app/di/app_scope.dart';
import 'package:chatter_solo_serfers/assets/strings/strings.dart';
import 'package:chatter_solo_serfers/common/classes/data_chat_card.dart';
import 'package:chatter_solo_serfers/common/classes/message.dart';
import 'package:chatter_solo_serfers/service/states/bloc_state.dart';
import 'package:chatter_solo_serfers/ui/screen/chat_model.dart';
import 'package:chatter_solo_serfers/ui/screen/chat_screen.dart';
import 'package:chatter_solo_serfers/utils/dialog_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Factory for [CountryListScreenWidgetModel]
ChatVM ChatVMFactory(
  BuildContext context,
) {
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
  /// Controller for show [SnackBar].
  final DialogController dialogController;

  late final StreamSubscription<BaseChatState> _stateStatusSubscription;
  final _controller = TextEditingController();
  String _username = 'anon';
  bool _isReady = false;

  @override
  TextEditingController get controller => _controller;

  @override
  late Query<DataChatCard> stream;

  @override
  bool get isReady => _isReady;

  @override
  String get userName => _username;

  @override
  bool chatMode = false;

  @override
  StateNotifier<bool> chatModeValue = StateNotifier<bool>();

  @override
  StateNotifier<bool> prepareStatusValue = StateNotifier<bool>();

  @override
  StateNotifier<String> userNameValue = StateNotifier<String>();

  /// Create an instance [AboutMeScreenWidgetModel].
  ChatVM({
    required ChatModel model,
    required this.dialogController,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _acceptValues();
    _stateStatusSubscription = model.profileStateStream.listen(_updateState);
    _getChatStream();
  }

  /// maybe no need, but for now
  void _acceptValues() {
    chatModeValue.accept(chatMode);
    userNameValue.accept(_username);
  }

  void _getChatStream() {
    model.prepareChat();
  }

  @override
  void dispose() {
    _stateStatusSubscription.cancel();
    super.dispose();
  }

  void _updateState(BaseChatState state) {
    if (state is ChatStreamState) {
      _isReady = true;
      stream = state.chatStream;
      prepareStatusValue.accept(_isReady);
    }
  }

  @override
  void sendMessage() {
    if (controller.text.trim() != "") {
      model.sendMessage(
        Message(
          controller.text,
          userName,
          DateTime.now(),
        ),
      );
    }
    controller.clear();
  }

  @override
  void updateAboutMe() {
    if (controller.text.trim() != "") {
      _username = controller.text;
      userNameValue.accept(_username);
    }
    controller.clear();
  }

  @override
  void changeMode() {
    controller.clear();
    if (_username == 'anon' && chatMode == false) {
      dialogController.showSnackBar(context, Strings.anonSnack);
    }
    chatMode = !chatMode;
    chatModeValue.accept(chatMode);
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

  Query<DataChatCard> get stream;

  bool get chatMode;

  String get userName;

  bool get isReady;

  late final StateNotifier<bool> chatModeValue;
  late final StateNotifier<bool> prepareStatusValue;
  late final StateNotifier<String> userNameValue;

  /// Function to save user info in [Profile].
  void updateAboutMe();

  void sendMessage();

  void changeMode();
}
