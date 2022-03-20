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
              child: StateNotifierBuilder<bool>(
                listenableState: wm.somePropertyWithIntegerValue2,
                builder: (ctx, value) {
                  return Expanded(
                    child: value ?? false
                        ? FirestoreQueryBuilder<DataChatCard>(
                            // query: moviesCollection,
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
                                  // if we reached the end of the currently obtained items, we try to
                                  // obtain more items
                                  if (snapshot.hasMore &&
                                      index + 1 == snapshot.docs.length) {
                                    // Tell FirestoreQueryBuilder to try to obtain more items.
                                    // It is safe to call this function from within the build method.
                                    snapshot.fetchMore();
                                  }
                                  final movie = snapshot.docs[index];
                                  return ChatCard(true, movie.get("text"));
                                },
                              );
                            })
                        : Text("da"),
                  );
                },
              ),
            ),
            StateNotifierBuilder<bool>(
              listenableState: wm.somePropertyWithIntegerValue,
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
                      ? const Icon(Icons.account_circle, key: ValueKey('icon1'))
                      : const Icon(
                          Icons.add_comment,
                          key: ValueKey('icon2'),
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
