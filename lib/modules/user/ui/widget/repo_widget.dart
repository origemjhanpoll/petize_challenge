import 'package:flutter/material.dart';
import 'package:petize_challenge/modules/user/ui/widget/label_widget.dart';

class RepoWidget extends StatelessWidget {
  final String name;
  final String? description;
  final int stargazersCount;
  final String updatedAt;
  final VoidCallback? onTap;

  const RepoWidget({
    super.key,
    required this.name,
    this.description,
    required this.stargazersCount,
    required this.updatedAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.0,
      children: [
        Text(
          name,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge!
              .copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              description!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style:
                  theme.textTheme.bodyLarge!.copyWith(color: Color(0xFF4A5568)),
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: [
            LabelWidget(
              text: stargazersCount.toString(),
              icon: Icons.star_border_purple500_rounded,
            ),
            Text('*'),
            Text(
              updatedAt,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style:
                  theme.textTheme.bodyLarge!.copyWith(color: Color(0xFF4A5568)),
            ),
          ],
        ),
      ],
    );
  }
}
