import 'package:casino_test/presentation/ui/exception_indicators/exception_indicator.dart';
import 'package:flutter/material.dart';

/// Indicates that a connection error occurred.
class NoConnectionIndicator extends StatelessWidget {
  const NoConnectionIndicator({
    Key? key,
    required this.onTryAgain,
  }) : super(key: key);

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'No connection',
        message: 'Please check internet connection and try again.',
        icon: Icons.wifi_off_rounded,
        onTryAgain: onTryAgain,
      );
}
