import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      //here we are listening to the stream of data from firebase
      //stream in here menas the data which we have to look after
      builder: (context, chatsnapshot) {
        //here chat snapshot will give us the data from firebase that is being communicated
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
