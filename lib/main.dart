import 'package:flutter/material.dart';
import 'package:github_client/app/ui/pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    ),
  );
}
