import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  final String name;
  final String user;
  final String avatarUrl;
  final int followers;
  final int following;
  final String? email;
  final String? bio;
  final String? company;
  final String? location;
  final String? site;
  final String? twitterUsername;

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
    this.site,
    this.twitterUsername,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
      child: Column(
        spacing: 16.0,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
            title: Text(name),
            subtitle: Text(user),
          ),
          if (bio != null) Text(bio!),
          if (company != null) Text(company!),
          if (location != null) Text(location!),
          if (email != null) Text(email!),
          if (site != null) Text(site!),
          if (twitterUsername != null) Text(twitterUsername!),
        ],
      ),
    );
  }
}
