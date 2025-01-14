import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/core/widgets/empty_widget.dart';
import 'package:petize_challenge/modules/search/ui/cubit/search_cubit.dart';
import 'package:petize_challenge/modules/search/ui/state/search_state.dart';
import 'package:petize_challenge/modules/search/ui/widget/user_item.dart';

class SearchPage extends StatefulWidget {
  final SearchCubit cubit;
  const SearchPage({super.key, required this.cubit});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit _cubit;
  late TextEditingController controller;
  late FocusNode focusNode;
  final hiddenFooter = ValueNotifier<bool>(false);

  @override
  void initState() {
    _cubit = widget.cubit;
    controller = TextEditingController();
    focusNode = FocusNode();

    _cubit.loadRecentUsers();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    focusNode.dispose();
    hiddenFooter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: _cubit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      child: Row(
                        spacing: 16.0,
                        children: [
                          Flexible(
                            child: TextField(
                              focusNode: focusNode,
                              controller: controller,
                              enableSuggestions: false,
                              autocorrect: false,
                              onTapOutside: (_) => focusNode.unfocus(),
                              onSubmitted: (_) =>
                                  _cubit.load(user: controller.text),
                              decoration: InputDecoration(
                                labelText: 'Buscar usuários',
                                hintText: 'ex.: joao123',
                                suffixIcon: ValueListenableBuilder(
                                  valueListenable: controller,
                                  builder: (context, value, child) {
                                    if (value.text.isNotEmpty) {
                                      return IconButton(
                                        onPressed: () {
                                          controller.clear();
                                          hiddenFooter.value = false;
                                          _cubit.loadRecentUsers();
                                        },
                                        icon: Icon(Icons.cancel),
                                      );
                                    } else {
                                      return LimitedBox();
                                    }
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(width: 1),
                                ),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: controller,
                            builder: (context, value, child) {
                              return IconButton.filled(
                                onPressed: value.text.isNotEmpty
                                    ? () => _cubit.load(user: controller.text)
                                    : null,
                                style: ButtonStyle(
                                  minimumSize:
                                      WidgetStatePropertyAll(Size.square(56.0)),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                                icon: const Icon(Icons.search),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    BlocConsumer<SearchCubit, SearchState>(
                      listener: (context, state) {
                        if (state is SearchError) {
                          final snackBar = SnackBar(
                              content: Text(state.errorMessage),
                              showCloseIcon: true);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (state is SearchSuccess) {
                          hiddenFooter.value = state.search.items.isNotEmpty;
                        }
                      },
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return Expanded(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (state is SearchSuccess) {
                          final search = state.search;
                          return Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    '${state.search.totalCount} Usuários encontrados',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                ),
                                Flexible(
                                  child: ListView.separated(
                                    itemCount: search.items.length,
                                    itemBuilder: (_, index) {
                                      final user = search.items[index];
                                      return UserItemWidget(
                                        onTap: () {
                                          Modular.to
                                              .pushNamed(
                                            '/user',
                                            arguments: user.login,
                                          )
                                              .whenComplete(() {
                                            _cubit.saveRecentUser(user: user);
                                            hiddenFooter.value = false;
                                            controller.clear();
                                          });
                                        },
                                        login: user.login,
                                        avatarUrl: user.avatarUrl,
                                        htmlUrl: user.htmlUrl,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      endIndent: 16.0,
                                      indent: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is SearchRecentUses) {
                          final recentUsers = state.recentUsers;
                          return Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Usuários recentes',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _cubit.clearRecentUsers();
                                    },
                                    icon: Icon(
                                      Icons.auto_delete,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: recentUsers.length,
                                    itemBuilder: (_, index) {
                                      final recentUser = recentUsers[index];
                                      return UserItemWidget(
                                        onTap: () {
                                          _cubit.saveRecentUser(
                                              user: recentUser);
                                          Modular.to.pushNamed(
                                            '/user',
                                            arguments: recentUser.login,
                                          );
                                        },
                                        login: recentUser.login,
                                        avatarUrl: recentUser.avatarUrl,
                                        htmlUrl: recentUser.htmlUrl,
                                        icon: Icons.history,
                                        iconColor: theme.hintColor,
                                        visualDensity: VisualDensity.compact,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      endIndent: 16.0,
                                      indent: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is SearchEmpty) {
                          return Expanded(
                            child: EmptyWidget(
                              supplementaryText: controller.text,
                              text: "Nenhum usuário encontrado para",
                              buttonText: 'Voltar',
                            ),
                          );
                        }

                        return LimitedBox();
                      },
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: hiddenFooter,
                builder: (context, value, child) {
                  if (value) {
                    return LimitedBox();
                  }
                  return RichText(
                    text: TextSpan(
                      text: 'Created by ',
                      style: theme.textTheme.labelSmall,
                      children: const [
                        TextSpan(
                            text: '@origemjhanpoll',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
