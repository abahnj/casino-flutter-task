import 'package:casino_test/src/presentation/ui/exception_indicators/exception_indicator.dart';
import 'package:flutter/material.dart';

/// Indicates that no items were found.
class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({super.key});

  @override
  Widget build(BuildContext context) => const ExceptionIndicator(
        title: 'Too much filtering',
        message: 'We couldn\'t find any results matching your applied filters.',
        icon: Icons.error_outline_rounded,
      );
}
