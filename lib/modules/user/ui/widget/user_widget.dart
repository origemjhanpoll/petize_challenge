import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petize_challenge/core/constant/screen_size.dart';
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
  final VoidCallback? onBlog;
  final VoidCallback? onTwitter;

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
    this.onBlog,
    this.onTwitter,
  });

  @override
  Widget build(BuildContext context) {
    final isScreenMedium = MediaQuery.of(context).size.width > ScreenSize.small;
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: isScreenMedium ? 280.0 : ScreenSize.large),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
            child: ClipPath(
              clipper: CustomBackgroundClipper(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16.0)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0).copyWith(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: onTap,
                          visualDensity: isScreenMedium
                              ? VisualDensity.compact
                              : VisualDensity.standard,
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(avatarUrl),
                            backgroundColor: theme.colorScheme.inversePrimary,
                            maxRadius: 24.0,
                            child: CachedNetworkImage(
                              imageUrl: avatarUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
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
                            style: theme.textTheme.titleLarge!.copyWith(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('@$user'),
                          contentPadding: EdgeInsets.only(right: 54.0),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        ),
                        Wrap(
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
                                maxLines: 2,
                                icon: Icons.link_outlined,
                                text: blog!,
                                onTap: onBlog,
                              ),
                            if (twitterUsername != null)
                              LabelWidget(
                                icon: Icons.link_outlined,
                                text: 'x.com/$twitterUsername',
                                onTap: onTwitter,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (onTap != null)
            Positioned(
              right: 16.0,
              top: 16.0,
              child: IconButton.filled(
                  iconSize: 38,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                  ),
                  onPressed: onClose,
                  icon: Icon(Icons.close)),
            ),
        ],
      ),
    );
  }
}

class CustomBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double borderRadius = 12.0;
    const double cutoutSize = 60.0;
    final Path path = Path();

    final double width = size.width;
    final double height = size.height;

    path.moveTo(width - cutoutSize - borderRadius, 0);
    path.quadraticBezierTo(
      width - cutoutSize,
      0,
      width - cutoutSize,
      borderRadius,
    );

    path.lineTo(width - cutoutSize, cutoutSize - (borderRadius + 6));
    path.quadraticBezierTo(
      width - cutoutSize,
      cutoutSize,
      width - cutoutSize + (borderRadius + 6),
      cutoutSize,
    );

    path.lineTo(width - borderRadius, cutoutSize);

    path.quadraticBezierTo(
      width,
      cutoutSize,
      width,
      cutoutSize + borderRadius,
    );

    path.lineTo(width, height - borderRadius);

    path.quadraticBezierTo(
      width,
      height,
      width - borderRadius,
      height,
    );

    path.lineTo(borderRadius, height);

    path.quadraticBezierTo(
      0,
      height,
      0,
      height - borderRadius,
    );

    path.lineTo(0, borderRadius);

    path.quadraticBezierTo(
      0,
      0,
      borderRadius,
      0,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
