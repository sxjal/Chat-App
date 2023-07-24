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
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Row(children: [
          CircularProgressIndicator(),
          Text("Loading!"),
        ]),
      ),
    );
  }
}
