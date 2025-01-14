import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final int maxLines;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const LabelWidget({
    super.key,
    required this.text,
    required this.icon,
    this.textStyle,
    this.maxLines = 1,
    this.color = const Color(0xFF4A5568),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  theme.textTheme.bodyMedium!.copyWith(
                      color: onTap != null ? theme.primaryColor : color),
              maxLines: maxLines,
            ),
          ),
        ],
      ),
    );
  }
}
