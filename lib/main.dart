import 'package:casino_test/bootstrap.dart';
import 'package:casino_test/core/di/main_di_module.dart';
import 'package:casino_test/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';

void main() {
  locatorSetup();

  bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      home: const CharacterScreen(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
    );
  }
}
