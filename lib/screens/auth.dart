import 'dart:io';

import 'package:chatapp/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();
  var _islogin = true;
  var passwordshown = false;
  var _enteredemail = "";
  var _enteredpassword = "";
  File? _selectedimage;

  void _submit() async {
    final _isvalid = _formkey.currentState!.validate();
    String? errorcode;
    if (!_isvalid || !_islogin && _selectedimage == null) return;

    _formkey.currentState!.save();
    try {
      if (_islogin) {
        // Log user in
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredemail, password: _enteredpassword);
      } else {
        // Sign user up
        //upload data to the database when user is created.

        //creating new user
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredemail, password: _enteredpassword);

        //updating uers details
        //display name
        _firebase.currentUser!.updateDisplayName(_enteredemail);
        //profile image
        final firebaseimageupload = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(
                '${userCredentials.user!.uid}.jpg'); //could also use _firebase.currentUser!.uid
        firebaseimageupload.putFile(_selectedimage!);
        final imageurl = firebaseimageupload.getDownloadURL();
        print(imageurl.toString());
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        errorcode = 'The account already exists for that email.';
      } else if (error.code == 'weak-password') {
        errorcode = 'The password provided is too weak.';
      } else if (error.code == 'invalid-email') {
        errorcode = 'The email address is not valid.';
      } else if (errorcode == "user-disabled") {
        errorcode = "The user account has been disabled by an administrator.";
      } else if (errorcode == "user-not-found") {
        errorcode =
            "There is no user record corresponding to this identifier. The user may have been deleted.";
      } else if (errorcode == "wrong-password") {
        errorcode =
            "The username or password is invalid or the user does not have a password.";
      } else {
        errorcode = error.message;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorcode ?? 'An error occured! Please try again.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                height: 100,
                child: Image.asset('assets/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_islogin)
                            UserImagePicker(
                              onpickimage: (pickedimage) {
                                _selectedimage = pickedimage;
                              },
                            ),
                          TextFormField(
                            key: const ValueKey('email'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            autofocus: true,
                            validator: (value) => (value!.trim().isEmpty ||
                                    !value.contains('@') ||
                                    !value.contains('.com'))
                                ? 'Please enter a valid Email Address'
                                : null,
                            onSaved: (newValue) => _enteredemail = newValue!,
                          ),
                          TextFormField(
                            key: const ValueKey('password'),
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffix: passwordshown == false
                                  ? IconButton(
                                      icon: const Icon(Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          passwordshown = true;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          passwordshown = false;
                                        });
                                      },
                                    ),
                            ),
                            obscureText: passwordshown ? false : true,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            autofocus: true,
                            validator: (value) => (value!.trim().isEmpty ||
                                    value.trim().length < 6)
                                ? 'Password must be atleast 6 characters long'
                                : null,
                            onSaved: (newValue) => _enteredpassword = newValue!,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 8,
                              ),
                            ),
                            onPressed: _submit,
                            child: Text(_islogin ? 'Login' : "Sign-Up"),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextButton(
                            child: _islogin
                                ? const Text("Create an Account")
                                : const Text("Already have an account"),
                            onPressed: () {
                              setState(
                                () {
                                  _islogin = !_islogin;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
