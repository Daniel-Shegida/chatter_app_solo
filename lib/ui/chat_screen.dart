import 'package:chatter_solo_serfers/cart.dart';
import 'package:chatter_solo_serfers/ui/chat_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends ElementaryWidget<IChatWidgetModel> {
  const ChatScreen({
    Key? key,
    WidgetModelFactory wmFactory = ChatVMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IChatWidgetModel wm) {
    return Scaffold(

        appBar: AppBar(

          title: Text("test"),
        ),
        body: GestureDetector(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: wm.chat.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    // return ListView.builder(
                    //   itemCount: wm.list.length,
                    //   itemBuilder: (context, position) {
                    //     return ChatCard(true, wm.list[position].toString());
                    //   },
                    // );
                    return ListView(
                      children: snapshot.data!.docs.map((chat) {
                        return Center(
                          child: ListTile(
                            title: ChatCard(true, chat['text'].toString()),
                            onLongPress: () {
                              chat.reference.delete();
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                ),
              ),
              MessagePusher(wm.chatMode),
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
      this.isChatMode,{Key? key}) : super(key: key);
  bool isChatMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: isChatMode
                ? Icon(Icons.account_circle)
            : Icon(Icons.add_comment),
            iconSize: 25.0,
            // color: Theme.of(context).primaryColor,
            onPressed: isChatMode
                ?() {}
                :() {},
          ),
          Expanded(
            child: TextField(
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
                ?() {}
                :() {},
          ),
        ],
      ),
    );
  }
}
