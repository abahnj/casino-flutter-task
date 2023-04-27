import 'package:casino_test/bootstrap.dart';
import 'package:casino_test/src/domain/di/main_di_module.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  MainDIModule().configure(GetIt.I);

  bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test app',
      home: CharactersScreen(),
    );
  }
}
