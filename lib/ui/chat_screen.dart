import 'package:chatter_solo_serfers/ui/chat_vm.dart';
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
        body: Center(
          child: ListView.builder(
            itemCount: wm.list.length,
            itemBuilder: (context, position) {
              return Text(wm.list[position].toString());
            },
          ),
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: wm.diplay,
              tooltip: 'Increment',
              child: const Icon(Icons.add,
                  color: Colors.red),
            ),
            FloatingActionButton(
              onPressed: wm.diplay,
              tooltip: 'Increment',
              child: const Icon(Icons.add,
                  color: Colors.red),
            ),
          ],
        ));
  }
}