import 'package:flutter/material.dart';
import 'package:thumbnail_generator/screens/main_screen.dart';
import 'package:thumbnail_generator/screens/profile.dart';
import 'package:thumbnail_generator/utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismissKeyboard,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Profile(),
      ),
    );
  }
}
