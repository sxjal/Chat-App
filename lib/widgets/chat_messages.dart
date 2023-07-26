import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      //here we are listening to the stream of data from firebase
      //stream in here menas the data which we have to look after
      builder: (context, chatsnapshot) {
        //here chat snapshot will give us the data from firebase that is being communicated
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!chatsnapshot.hasData || chatsnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No messages yet!"),
          );
        }

        if (chatsnapshot.hasError) {
          return const Center(
            child: Text("Something went wrong!"),
          );
        }
        final loadedmsg = chatsnapshot.data!.docs;
        return ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 40,
              left: 30,
              right: 30,
            ),
            reverse: true,
            itemBuilder: (ctx, index) {
              final chatmsg = loadedmsg[index]["text"];
              final nextchatmsg = index + 1 < loadedmsg.length
                  ? chatsnapshot.data!.docs[index + 1]["text"]
                  : null;
            },
            itemCount: chatsnapshot.data!.docs.length);
      },
    );
  }
}
