import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compra/consts/consts.dart';
import 'package:compra/controller/messages_controller.dart';
import 'package:compra/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserAdminMessaging extends StatefulWidget {
  final dynamic data;
  const UserAdminMessaging({super.key, this.data});

  @override
  _UserAdminMessagingState createState() => _UserAdminMessagingState();
}

class _UserAdminMessagingState extends State<UserAdminMessaging> {
  final TextEditingController _messageController = TextEditingController();

  void sendMessage(String message) {
    FirebaseFirestore.instance.collection('messages').add({
      'text': message,
      'sender_id': currentUser!.uid, // You can distinguish between 'user' and 'admin'
      // 'sender_name': currentUser!.username, // You can distinguish between 'user' and 'admin'
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MessagesController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Messaging",style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return loadingIndicator();
                }
                var messages = snapshot.data!.docs.reversed;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  final text = message['text'];
                  final sender = message['sender_id'];
                  final messageWidget = MessageWidget(sender: sender, text: text);
                  messageWidgets.add(messageWidget);
                }
                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(labelText: "Type a message"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    controller.sendMsg(controller.messageController.text);
                    controller.messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;

  MessageWidget({required this.sender, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      subtitle: Text(sender),
    );
  }
}

