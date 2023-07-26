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

  void _submitmessage() {
    final enteredtext = _textmsgcontroller.text;
    if (enteredtext.isEmpty) {
      return;
    }
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
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                labelText: "Send a message...",
              ),
              controller: _textmsgcontroller,
              onSubmitted: (value) => value.isEmpty ? "cannot be null" : null,
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
