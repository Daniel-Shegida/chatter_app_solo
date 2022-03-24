import 'package:chatter_solo_serfers/ui/widget/cart.dart';
import 'package:chatter_solo_serfers/common/classes/data_chat_card.dart';
import 'package:chatter_solo_serfers/ui/screen/chat_vm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../assets/strings/strings.dart';

class ChatScreen extends ElementaryWidget<IChatWidgetModel> {
  const ChatScreen({
    Key? key,
    WidgetModelFactory wmFactory = ChatVMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IChatWidgetModel wm) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(Strings.chatTitle),
      ),
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
              child: DoubleSourceBuilder<bool, String>(
                firstSource: wm.prepareStatusValue,
                secondSource: wm.userNameValue,
                builder: (ctx, value, user) {
                  return Expanded(
                    child: value ?? false
                        ? FirestoreQueryBuilder<DataChatCard>(
                            query: wm.stream,
                            builder: (context, snapshot, _) {
                              if (snapshot.isFetching) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('error ${snapshot.error}');
                              }
                              return ListView.builder(
                                reverse: true,
                                controller: ScrollController(),
                                itemCount: snapshot.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.hasMore &&
                                      index + 1 == snapshot.docs.length) {
                                    snapshot.fetchMore();
                                  }
                                  final chat = snapshot.docs[index];
                                  return ChatCard((chat.get("user") == user),
                                      chat.get("text"));
                                },
                              );
                            })
                        : const CircularProgressIndicator(),
                  );
                },
              ),
            ),
            StateNotifierBuilder<bool>(
              listenableState: wm.chatModeValue,
              builder: (ctx, value) {
                return MessagePusher(value ?? false, wm.sendMessage,
                    wm.updateAboutMe, wm.changeMode, wm.controller);
              },
            )
          ],
        ),
      ),
    );
  }
}

class MessagePusher extends StatelessWidget {
  const MessagePusher(this.isChatMode, this.sendMessage, this.changeUser,
      this.changeMode, this.textEditingController,
      {Key? key})
      : super(key: key);
  final bool isChatMode;
  final Function() sendMessage;
  final Function() changeUser;
  final Function() changeMode;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => RotationTransition(
                        turns: child.key == const ValueKey('icon1')
                            ? Tween<double>(begin: 0.75, end: 1).animate(anim)
                            : Tween<double>(begin: 0.75, end: 1).animate(anim),
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                  child: isChatMode
                      ? const Icon(
                          Icons.add_comment,
                          key: ValueKey('icon2'),
                        )
                      : const Icon(
                          Icons.account_circle,
                          key: ValueKey('icon1'),
                        )),
              onPressed: changeMode),
          Expanded(
            child: TextField(
              controller: textEditingController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: isChatMode ? Strings.sendHint : Strings.changeHint,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            onPressed: isChatMode ? sendMessage : changeUser,
          ),
        ],
      ),
    );
  }
}
