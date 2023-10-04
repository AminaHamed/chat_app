class Message {
  static const String collectionName = 'messages';
  String? roomId;
  String? messageId;
  String? senderId;
  String? senderName;
  String? messageContent;
  DateTime? messageTime;

  Message(
      {required this.roomId,
      this.messageId,
      required this.senderId,
      required this.senderName,
      required this.messageContent,
      required this.messageTime});

  Map<String, dynamic> toFireStore() {
    return {
      'roomId': roomId,
      'messageId': messageId,
      'senderId': senderId,
      'senderName': senderName,
      'messageContent': messageContent,
      'messageTime': messageTime?.millisecondsSinceEpoch,
    };
  }

  Message.fromFireStore(Map<String, dynamic> data)
      : this(
          roomId: data['roomId'],
          messageId: data['messageId'],
          senderId: data['senderId'],
          senderName: data['senderName'],
          messageContent: data['messageContent'],
          messageTime: DateTime.fromMillisecondsSinceEpoch(data['messageTime']),
        );
}
