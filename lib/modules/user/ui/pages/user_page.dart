import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/core/constant/screen_size.dart';
import 'package:petize_challenge/core/widgets/empty_widget.dart';
import 'package:petize_challenge/core/widgets/error_app_widget.dart';
import 'package:petize_challenge/core/widgets/paginated_scrollview_widget.dart';
import 'package:petize_challenge/modules/user/domain/models/repo_info_model.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/widget/repo_widget.dart';
import 'package:petize_challenge/modules/user/ui/widget/sort_repository_list_widget.dart';
import 'package:petize_challenge/modules/user/ui/widget/user_widget.dart';
import 'package:petize_challenge/utils/launch_config.dart';

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
  final _repoUrl = ValueNotifier<RepoInfoModel>(RepoInfoModel());

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
    _repoUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isScreenMedium = MediaQuery.of(context).size.width > ScreenSize.small;

    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>.value(value: _userCubit),
            BlocProvider<RepoCubit>.value(value: _repoCubit),
          ],
          child: Flex(
            direction: isScreenMedium ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserSuccess) {
                    _repoCubit.load(
                        isNewSearch: true, url: state.user.reposUrl);
                    _repoUrl.value = RepoInfoModel(
                      url: state.user.reposUrl,
                      maximumLength: state.user.publicRepos,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is UserSuccess) {
                    final user = state.user;
                    return UserWidget(
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
                      onTwitter: user.twitterUsername != null
                          ? () {
                              final Uri toLaunch = Uri.parse(
                                  'https://x.com/${user.twitterUsername!}');
                              launchInAppWithBrowserOptions(toLaunch);
                            }
                          : null,
                      onBlog: user.blog != null
                          ? () {
                              final Uri toLaunch = Uri.parse(user.blog!);
                              launchInAppWithBrowserOptions(toLaunch);
                            }
                          : null,
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
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _repoUrl,
                      builder: (context, repoInfo, child) {
                        if (repoInfo.url.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, top: 22.0, right: 16.0),
                            child: SortRepositoryListWidget(
                              title:
                                  '${repoInfo.length}/${repoInfo.maximumLength} Repositórios',
                              onPressed: repoInfo.maximumLength != 0
                                  ? (sort, direction) {
                                      _repoCubit.load(
                                        isNewSearch: true,
                                        url: repoInfo.url,
                                        sort: sort,
                                        direction: direction,
                                      );
                                    }
                                  : null,
                            ),
                          );
                        }

                        return LimitedBox();
                      },
                    ),
                    BlocConsumer<RepoCubit, RepoState>(
                      listener: (context, state) {
                        if (state is RepoSuccess) {
                          _repoUrl.value = _repoUrl.value
                              .copyWith(length: state.repos.length);
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is RepoLoading ||
                          current is RepoSuccess ||
                          current is RepoEmpty ||
                          current is RepoError,
                      builder: (context, state) {
                        if (state is RepoLoading) {
                          return Expanded(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (state is RepoSuccess) {
                          return Flexible(
                            child: PaginatedScrollViewWidget(
                              onLoadMore: () {
                                _repoCubit.load();
                              },
                              isLoadingMore: state is RepoLoadingMore,
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
                                separatorBuilder: (context, index) => Divider(
                                    height: 0.0, endIndent: 16.0, indent: 16.0),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
