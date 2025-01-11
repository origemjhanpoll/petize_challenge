import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/widget/repo_widget.dart';
import 'package:petize_challenge/modules/user/ui/widget/user_widget.dart';

class UserPage extends StatefulWidget {
  final UserCubit userCubit;
  final RepoCubit repoCubit;
  const UserPage({super.key, required this.userCubit, required this.repoCubit});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserCubit _userCubit;
  late RepoCubit _repoCubit;
  late ScrollController controller;
  @override
  void initState() {
    _userCubit = widget.userCubit;
    _repoCubit = widget.repoCubit;
    _userCubit.load(user: 'origemjhanpoll');
    super.initState();
  }

  @override
  void dispose() {
    _repoCubit.close();
    _userCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(create: (_) => _userCubit),
            BlocProvider<RepoCubit>(create: (_) => _repoCubit),
          ],
          child: Flex(
            direction: Axis.vertical,
            children: [
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state.isLoaded) {
                    _repoCubit.load(url: state.user.reposUrl);
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.isLoaded) {
                    final user = state.user;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: UserWidget(
                        onTap: () {},
                        name: user.name,
                        user: user.login,
                        avatarUrl: user.avatarUrl,
                        bio: user.bio,
                        company: user.company,
                        location: user.location,
                        email: user.email,
                        blog: user.blog,
                        twitterUsername: user.twitterUsername,
                        followers: user.followers,
                        following: user.following,
                      ),
                    );
                  } else if (state.hasError) {
                    return Center(
                      child: Text(
                        '${state.errorMessage}',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return LimitedBox();
                },
              ),
              BlocBuilder<RepoCubit, RepoState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.isLoaded) {
                    return Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.separated(
                          itemCount: state.repos.length,
                          itemBuilder: (_, index) {
                            final repo = state.repos[index];
                            return RepoWidget(
                              name: repo.name,
                              description: repo.description ??
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus.',
                              stargazersCount: repo.stargazersCount,
                              updatedAt: repo.updatedAt,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Divider(height: 32.0),
                        ),
                      ),
                    );
                  } else if (state.hasError) {
                    return Center(
                      child: Text(
                        '${state.errorMessage}',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return LimitedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
