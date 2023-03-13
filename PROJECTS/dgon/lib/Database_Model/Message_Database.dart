import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDatabase {
  final String? MessageID;
  final String? GroupName;
  final String? SenderID;
  final String? Sender;
  final String? MessageType;
  final String? Message;
  final DateTime? Sent;

  const MessageDatabase({
    required this.MessageID,
    required this.GroupName,
    required this.SenderID,
    required this.Sender,
    required this.MessageType,
    required this.Message,
    required this.Sent,
  });

  Map<String, dynamic> toJson() => {
        "MessageID": MessageID,
        "GroupName": GroupName,
        "SenderID": SenderID,
        "Sender": Sender,
        "MessageType": MessageType,
        "Message": Message,
        "Sent": Sent,
      };

  factory MessageDatabase.fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MessageDatabase(
      MessageID: snap['MessageID'],
      GroupName: snap['GroupName'],
      SenderID: snap['SenderID'],
      Sender: snap['Sender'],
      MessageType: snap['MessageType'],
      Message: snap['Message'],
      Sent: snap['Sent'],
    );
  }
}
