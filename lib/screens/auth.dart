import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var passwordshown = false;
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
