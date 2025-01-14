import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/core/widgets/empty_widget.dart';
import 'package:petize_challenge/core/widgets/error_app_widget.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/widget/repo_widget.dart';
import 'package:petize_challenge/modules/user/ui/widget/sort_repository_list_widget.dart';
import 'package:petize_challenge/modules/user/ui/widget/user_widget.dart';

class RepoInfo {
  final String url;
  final int length;
  const RepoInfo({this.url = '', this.length = 0});
}

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
  final repoUrl = ValueNotifier<RepoInfo>(RepoInfo());

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
                    repoUrl.value = RepoInfo(
                      url: state.user.reposUrl,
                      length: state.user.publicRepos,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is UserSuccess) {
                    final user = state.user;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: UserWidget(
                        onTap: () {
                          Modular.to.pushNamed(
                            '/view',
                            arguments: {
                              'title': user.name,
                              'url': user.htmlUrl,
                            },
                          );
                        },
                        onClose: () => Modular.to.pop(),
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
                      child: ErrorAppWidget(
                        message: state.errorMessage,
                        onTap: Modular.to.pop,
                      ),
                    );
                  }
                  return LimitedBox();
                },
              ),
              ValueListenableBuilder(
                valueListenable: repoUrl,
                builder: (context, repoInfo, child) {
                  if (repoInfo.url.isNotEmpty) {
                    return SortRepositoryListWidget(
                      title: '${repoInfo.length} Repositórios',
                      onPressed: (sort, direction) {
                        _repoCubit.load(
                          url: repoInfo.url,
                          sort: sort,
                          direction: direction,
                        );
                      },
                    );
                  }

                  return LimitedBox();
                },
              ),
              BlocBuilder<RepoCubit, RepoState>(
                builder: (context, state) {
                  if (state is RepoLoading) {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is RepoSuccess) {
                    return Flexible(
                      child: ListView.separated(
                        itemCount: state.repos.length,
                        itemBuilder: (_, index) {
                          final repo = state.repos[index];
                          return RepoWidget(
                            onTap: () {
                              Modular.to.pushNamed(
                                '/view',
                                arguments: {
                                  'title': repo.name,
                                  'url': repo.htmlUrl
                                },
                              );
                            },
                            name: repo.name,
                            description: repo.description,
                            stargazersCount: repo.stargazersCount,
                            updatedAt: repo.updatedAt,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 0.0, endIndent: 16.0, indent: 16.0),
                      ),
                    );
                  } else if (state is RepoEmpty) {
                    return Expanded(
                      child: EmptyWidget(text: 'Nenhum repositório'),
                    );
                  } else if (state is RepoError) {
                    return Expanded(
                      child: ErrorAppWidget(message: state.errorMessage),
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
