import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textmsgcontroller = TextEditingController();

  void dispose() {
    _textmsgcontroller.dispose();
    super.dispose();
  }

  void _submitmessage() async {
    final enteredtext = _textmsgcontroller.text;
    if (enteredtext.isEmpty) {
      return;
    }
    _textmsgcontroller.clear();
    final currentusername = FirebaseAuth.instance.currentUser!.uid;
    final currentprofilepicture = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    FirebaseFirestore.instance.collection("chat").add(
      {
        "text": enteredtext,
        "createdAt": Timestamp.now(),
        "userid": FirebaseAuth.instance.currentUser,
        "username": currentusername,
        "userimage": currentprofilepicture["image_url"],
      },
    );
    //send data to firebase
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 1,
        bottom: 14,
        left: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                labelText: "Send a message...",
              ),
              controller: _textmsgcontroller,
            ),
          ),
          IconButton(
            onPressed: _submitmessage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
