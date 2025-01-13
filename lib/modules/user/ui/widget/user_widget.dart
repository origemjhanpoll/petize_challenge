import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petize_challenge/modules/user/ui/widget/label_widget.dart';

class UserWidget extends StatelessWidget {
  final String? name;
  final String user;
  final String avatarUrl;
  final int followers;
  final int following;
  final String? email;
  final String? bio;
  final String? company;
  final String? location;
  final String? blog;
  final String? twitterUsername;
  final VoidCallback? onTap;
  final VoidCallback? onClose;

  const UserWidget({
    super.key,
    required this.name,
    required this.user,
    required this.avatarUrl,
    this.followers = 0,
    this.following = 0,
    this.email,
    this.bio,
    this.company,
    this.location,
    this.blog,
    this.twitterUsername,
    this.onTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: onTap,
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(avatarUrl),
                backgroundColor: theme.colorScheme.inversePrimary,
                maxRadius: 24.0,
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      size: 38.0,
                      color: theme.primaryColor),
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      backgroundImage: imageProvider,
                      maxRadius: 24.0,
                    );
                  },
                ),
              ),
              title: Text(
                name ?? '--',
                style: theme.textTheme.titleLarge!
                    .copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('@$user'),
              contentPadding: EdgeInsets.zero,
              trailing: onTap != null
                  ? IconButton.outlined(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                        side: WidgetStatePropertyAll(
                            BorderSide(width: 2.0, color: theme.primaryColor)),
                      ),
                      onPressed: onClose,
                      icon: Icon(
                        Icons.close,
                        color: theme.primaryColor,
                      ))
                  : null,
            ),
            Row(
              spacing: 16.0,
              children: [
                LabelWidget(
                  text: '$followers seguidores',
                  icon: Icons.groups_outlined,
                ),
                LabelWidget(
                  text: '$following seguindo',
                  icon: Icons.favorite_border_outlined,
                ),
              ],
            ),
            if (bio != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  bio!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: Color(0xFF4A5568)),
                ),
              ),
            Wrap(
              runSpacing: 8.0,
              spacing: 16.0,
              alignment: WrapAlignment.center,
              children: [
                if (company != null)
                  LabelWidget(
                    icon: Icons.work_outline_rounded,
                    text: company!,
                  ),
                if (location != null)
                  LabelWidget(
                    icon: Icons.location_on_outlined,
                    text: location!,
                  ),
                if (email != null)
                  LabelWidget(
                    icon: Icons.email_outlined,
                    text: email!,
                  ),
                if (blog != null && blog!.isNotEmpty)
                  LabelWidget(
                    icon: Icons.link_outlined,
                    text: blog!,
                  ),
                if (twitterUsername != null)
                  LabelWidget(
                    icon: Icons.link_outlined,
                    text: twitterUsername!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
