import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Row(children: [
          CircularProgressIndicator(),
          Text("Loading!"),
        ]),
      ),
    );
  }
}
