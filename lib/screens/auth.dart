import 'package:flutter/material.dart';

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

  void _submit() {
    final _isvalid = _formkey.currentState!.validate();

    if (_isvalid) {
      _formkey.currentState!.save();
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
                          TextFormField(
                            key: const ValueKey('email'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            autofocus: true,
                            validator: (value) =>
                                (value!.trim().isEmpty || !value.contains('@'))
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
                            child: Text(_islogin ? 'Login' : "Sign Up"),
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
