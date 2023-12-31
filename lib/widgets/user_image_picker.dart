import "dart:io";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onpickimage});

  final void Function(File) onpickimage;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
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
    widget.onpickimage(_selectedimage!);
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
            child: const Text('Pick Image from Gallery'),
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
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _selectedimage != null ? FileImage(_selectedimage!) : null,
        ),
        TextButton.icon(
          onPressed: _takepicture,
          icon: const Icon(Icons.image),
          label: Text(
            "Add Image",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
