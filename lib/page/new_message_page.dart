import 'package:flutter/material.dart';

class NewMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('New Message'),
        centerTitle: true,
      ),
      body: Center(
        child: Icon(
          Icons.message,
          size: 120,
          color: Theme.of(context).primaryColor,
        ),
      ));
}
