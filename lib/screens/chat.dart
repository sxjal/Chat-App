import "package:chatapp/widgets/chat_messages.dart";
import "package:chatapp/widgets/new_message.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
      body: const Column(
        children: [
          ChatMessages(),
          NewMessage(),
        ],
      ),
    );
  }
}
