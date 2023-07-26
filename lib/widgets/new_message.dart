import "package:flutter/material.dart";

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
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
          const Expanded(
            child: TextField(),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
