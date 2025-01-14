import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? buttonText;
  final String text;
  final String? supplementaryText;
  const EmptyWidget({
    super.key,
    this.buttonText,
    required this.text,
    this.supplementaryText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                  text: text,
                  style: theme.textTheme.bodyMedium,
                  children: supplementaryText != null
                      ? [
                          const TextSpan(text: ' "'),
                          TextSpan(
                            text: supplementaryText,
                            style: theme.textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '".'),
                        ]
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}
