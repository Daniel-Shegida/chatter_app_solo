import 'package:flutter/material.dart';

class UISacfold extends StatelessWidget {
  UISacfold({Key? key}) : super(key: key);
  List<int> itemCount = [1,2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          title: Text("test"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: itemCount.length,
            itemBuilder: (context, position) {
              return Text(itemCount[position].toString());
            },
          ),
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add,
                color: Colors.red),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add,
                  color: Colors.red),
            ),
          ],
        ));
  }

  void _incrementCounter() {
  }
}
