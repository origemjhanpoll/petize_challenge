import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/widget/repo_widget.dart';
import 'package:petize_challenge/modules/user/ui/widget/user_widget.dart';

class UserPage extends StatefulWidget {
  final UserCubit userCubit;
  final RepoCubit repoCubit;
  final String user;
  const UserPage({
    super.key,
    required this.userCubit,
    required this.repoCubit,
    required this.user,
  });

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserCubit _userCubit;
  late RepoCubit _repoCubit;
  @override
  void initState() {
    _userCubit = widget.userCubit;
    _repoCubit = widget.repoCubit;
    _userCubit.load(user: widget.user);
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
            BlocProvider<UserCubit>.value(value: _userCubit),
            BlocProvider<RepoCubit>.value(value: _repoCubit),
          ],
          child: Flex(
            direction: Axis.vertical,
            children: [
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserSuccess) {
                    _repoCubit.load(url: state.user.reposUrl);
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserSuccess) {
                    final user = state.user;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: UserWidget(
                        onTap: () => Modular.to.pop(),
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
                  } else if (state is UserError) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => Modular.to.pop(),
                              label: Text('data'),
                              icon: Icon(Icons.back_hand),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return LimitedBox();
                },
              ),
              BlocBuilder<RepoCubit, RepoState>(
                builder: (context, state) {
                  if (state is RepoLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RepoSuccess) {
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
                  } else if (state is RepoError) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => Modular.to.pop(),
                              label: Text('data'),
                              icon: Icon(Icons.back_hand),
                            )
                          ],
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
