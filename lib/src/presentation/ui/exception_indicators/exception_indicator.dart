import 'package:flutter/material.dart';

enum ErrorType { conntection, generic }

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    required this.title,
    required this.icon,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              Icon(icon, size: 100, color: Theme.of(context).colorScheme.error),
              const SizedBox(
                height: 32,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (message != null)
                const SizedBox(
                  height: 16,
                ),
              if (message != null)
                Text(
                  message ?? "An error occurred. \nPlease try again later.",
                  textAlign: TextAlign.center,
                ),
              if (onTryAgain != null) ...[
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onTryAgain,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      );
}
