import 'package:chatter_solo_serfers/cart.dart';
import 'package:chatter_solo_serfers/chatCard.dart';
import 'package:chatter_solo_serfers/ui/chat_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/firestore.dart';


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

          title: Text("testing ground"),
        ),
        body: GestureDetector(
          child: Column(
            children: [
          Expanded(
            child: StateNotifierBuilder<bool>(
            listenableState: wm.somePropertyWithIntegerValue2,
              builder: (ctx, value) {
                return Expanded(
                    child: true
                    ?
                    FirestoreQueryBuilder<ChatCard2>(
                        query: moviesCollection.orderBy('timestamp', descending: true),
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
                              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                // Tell FirestoreQueryBuilder to try to obtain more items.
                                // It is safe to call this function from within the build method.
                                snapshot.fetchMore();
                              }

                              final movie = snapshot.docs[index];
                              return ChatCard(true, movie.get("text"));
                            },
                          );
                        }
                    )
                    // StreamBuilder(
                    //   stream: wm.stream,
                    //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     // return ListView.builder(
                    //     //   itemCount: wm.list.length,
                    //     //   itemBuilder: (context, position) {
                    //     //     return ChatCard(true, wm.list[position].toString());
                    //     //   },
                    //     // );
                    //     return ListView(
                    //       children: snapshot.data!.docs.map((chat) {
                    //         return Center(
                    //           child: ListTile(
                    //             title: ChatCard(true, chat['user'].toString()),
                    //             onLongPress: () {
                    //               chat.reference.delete();
                    //             },
                    //           ),
                    //         );
                    //       }).toList(),
                    //     );
                    //   }
                    // )
                        : Text("da"),
                  );
              },
            ),
          ),
              StateNotifierBuilder<bool>(
              listenableState: wm.somePropertyWithIntegerValue,
              builder: (ctx, value) {
                return MessagePusher(value?? false, wm.sendMessage, wm.updateAboutMe, wm.changeMode, wm.controller);
  },
    )

            ],
          ),
        ),
        // floatingActionButton: Row(
        //   children: [
        //     FloatingActionButton(
        //       onPressed: wm.diplay,
        //       tooltip: 'Increment',
        //       child: const Icon(Icons.add,
        //           color: Colors.red),
        //     ),
        //     FloatingActionButton(
        //       onPressed: wm.diplay,
        //       tooltip: 'Increment',
        //       child: const Icon(Icons.add,
        //           color: Colors.red),
        //     ),
        //   ],
        // )
    );
  }
}

class MessagePusher extends StatelessWidget {
  MessagePusher(
      this.isChatMode,
      this.sendMessage,
      this.changeUser,
      this.changeMode,
      this.textEditingController, {Key? key}) : super(key: key);
  bool isChatMode;
  Function() sendMessage;
  Function() changeUser;
  Function() changeMode;
  final textEditingController;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
      IconButton(
      icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: child.key == ValueKey('icon1')
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
    onPressed: changeMode
    ),
          // IconButton(
          //   icon: isChatMode
          //       ? Icon(Icons.account_circle)
          //   : Icon(Icons.add_comment),
          //   iconSize: 25.0,
          //   // color: Theme.of(context).primaryColor,
          //   onPressed: changeMode
          // ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            // color: Theme.of(context).primaryColor,
            onPressed: isChatMode
                ? sendMessage
                : changeUser,
          ),
        ],
      ),
    );
  }
}
