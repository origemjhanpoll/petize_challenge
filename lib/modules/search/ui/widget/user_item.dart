import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserItemWidget extends StatelessWidget {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final IconData? icon;
  final Color? iconColor;
  final VisualDensity? visualDensity;
  final VoidCallback? onTap;

  const UserItemWidget({
    super.key,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    this.icon,
    this.iconColor,
    this.visualDensity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      visualDensity: visualDensity,
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(avatarUrl),
        backgroundColor: theme.colorScheme.inversePrimary,
        maxRadius: 24.0,
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Icon(Icons.error_outline, size: 38.0, color: theme.primaryColor),
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              backgroundImage: imageProvider,
              maxRadius: 24.0,
            );
          },
        ),
      ),
      title: Text(
        '@$login',
        style:
            theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        htmlUrl.substring(8),
        style: theme.textTheme.bodyMedium,
      ),
      trailing: onTap != null
          ? IconButton(
              onPressed: onTap,
              icon: Icon(
                icon ?? Icons.navigate_next_rounded,
                color: iconColor ?? theme.primaryColor,
              ))
          : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
