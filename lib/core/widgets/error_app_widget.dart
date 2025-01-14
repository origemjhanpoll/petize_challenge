import 'package:flutter/material.dart';

class ErrorAppWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onTap;
  const ErrorAppWidget({
    super.key,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 38.0,
            Icons.error_outline_rounded,
            color: theme.colorScheme.error,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onTap != null)
            FilledButton(
              onPressed: onTap,
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
              ),
              child: Text('Voltar'),
            )
        ],
      ),
    );
  }
}
