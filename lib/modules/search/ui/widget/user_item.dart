import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserItemWidget extends StatelessWidget {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final VoidCallback? onTap;

  const UserItemWidget({
    super.key,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
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
        login,
        style: theme.textTheme.titleLarge!
            .copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      contentPadding: EdgeInsets.zero,
      trailing: onTap != null
          ? IconButton.outlined(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
                side: WidgetStatePropertyAll(
                    BorderSide(width: 2.0, color: theme.primaryColor)),
              ),
              onPressed: onTap,
              icon: Icon(
                Icons.navigate_next_rounded,
                color: theme.primaryColor,
              ))
          : null,
    );
  }
}
