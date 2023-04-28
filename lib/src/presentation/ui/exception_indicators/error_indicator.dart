import 'dart:io';

import 'package:casino_test/src/presentation/ui/exception_indicators/generic_error_indicator.dart';
import 'package:casino_test/src/presentation/ui/exception_indicators/no_connection_indicator.dart';
import 'package:flutter/material.dart';

/// Based on the received error, displays either a [NoConnectionIndicator] or
/// a [GenericErrorIndicator].
class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    this.error,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final Object? error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => error is SocketException
      ? NoConnectionIndicator(
          onTryAgain: onTryAgain ?? () => {},
        )
      : GenericErrorIndicator(
          onTryAgain: onTryAgain ?? () => {},
        );
}
