import 'package:flutter/material.dart';

class PageWithList extends StatelessWidget {
  const PageWithList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('New Screen'),
      ),
      body: Center(child: Text('This is your new screen')),
    );
  }
}
