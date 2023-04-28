import 'package:casino_test/src/presentation/ui/exception_indicators/exception_indicator.dart';
import 'package:flutter/material.dart';

class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({
    Key? key,
    required this.onTryAgain,
  }) : super(key: key);

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'Something went wrong',
        message: 'The application has encountered an unknown error.\n'
            'Please try again later.',
        icon: Icons.error_outline_rounded,
        onTryAgain: onTryAgain,
      );
}
