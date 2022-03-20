/// class for sending messages into cloud store
class Message{
  /// text of message
  final String textOfMessage;
  /// author of message
  final String author;
  /// time when message was sent
  final DateTime time;

  /// Create an instance [Message].
  Message(this.textOfMessage, this.author, this.time);

}