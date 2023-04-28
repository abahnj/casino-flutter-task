import 'package:casino_test/src/presentation/bloc/characters_bloc.dart';
import 'package:casino_test/src/presentation/bloc/characters_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<CharactersBloc>().add(const FetchCharacters());
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            textStyle: const TextStyle(fontSize: 18.0),
          ),
          child: const Text('Retry'),
        ),
      ),
    );
  }
}
