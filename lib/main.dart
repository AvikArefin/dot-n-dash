import 'package:dotndash/components/morsecodewidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DotNDashApp());

class DotNDashApp extends StatelessWidget {
  const DotNDashApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const MorseCodeWidget(),
    );
  }
}

