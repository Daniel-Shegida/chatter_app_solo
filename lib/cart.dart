import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(this.isUser, this.textOfCard, {Key? key}) : super(key: key);
  final bool isUser;
  final String textOfCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: isUser ? Colors.red : Colors.blue,
        borderRadius: isUser
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0))
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      margin: isUser
          ? const EdgeInsets.only(top: 6, bottom: 6, left: 60)
          : const EdgeInsets.only(top: 6, bottom: 6, right: 60),
      child: Text(textOfCard),
    );
  }
}
