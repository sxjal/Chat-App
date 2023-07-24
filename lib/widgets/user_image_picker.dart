import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  File? _selectedimage;
  final imagepicker = ImagePicker();
  var pickedimage;
  void _pickgallery() async {
    pickedimage = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    Navigator.pop(context);
    _onpickimage(pickedimage);
  }

  void _pickcamera() async {
    pickedimage = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    Navigator.pop(context);
    _onpickimage(pickedimage);
  }

  void _onpickimage(var pickedimage) {
    if (pickedimage == null) {
      return;
    } else {
      setState(() {
        _selectedimage = File(pickedimage.path);
      });
    }
  }

  void _takepicture() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Upload Image'),
        content: const Text('Select one!'),
        actions: [
          TextButton(
            onPressed: _pickgallery,
            child: const Text('Pick Image'),
          ),
          TextButton(
            onPressed: _pickcamera,
            child: const Text('Click Image'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          // foregroundImage: ,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.image),
          label: Text(
            "Add Image",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
