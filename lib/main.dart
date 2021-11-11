import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab_demo/expandable_fab.dart';

import 'fab_menu_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expandable Fab Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Expandable Fab Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SafeArea(
          child: Center(
        child: Text('Expandable Fab'),
      )),
      floatingActionButton: ExpandableFab(fabMenuItems: [
        FabMenuItem(
            icon: Icons.sms,
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Sms pressed')));
            }),
        FabMenuItem(
            icon: Icons.email,
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Email pressed')));
            }),
        FabMenuItem(
            icon: Icons.phone,
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Phone pressed')));
            }),
      ]),
    );
  }
}
