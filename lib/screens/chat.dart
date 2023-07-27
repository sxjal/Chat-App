import "package:chatapp/widgets/chat_messages.dart";
import "package:chatapp/widgets/new_message.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void init() {
    super.initState();
    FirebaseMessaging.instance.requestPermission();s
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: const ChatMessages(),
            ),
          ),
          const NewMessage(),
        ],
      ),
    );
  }
}
