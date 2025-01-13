import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  @override
  void initState() {
    _cubit = widget.cubit;
    controller = TextEditingController();
    focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _cubit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        onSubmitted: (_) => _cubit.load(user: controller.text),
                        decoration: InputDecoration(
                          labelText: 'Digite o usuário',
                          hintText: 'ex.: joao123',
                          prefixIcon: Icon(Icons.alternate_email_sharp),
                          suffixIcon: ValueListenableBuilder(
                            valueListenable: controller,
                            builder: (context, value, child) {
                              if (value.text.isNotEmpty) {
                                return IconButton(
                                  onPressed: () async {
                                    controller.clear();
                                    await _cubit.clean();
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
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is SearchSuccess) {
                    final search = state.search;
                    return Expanded(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('${state.search.totalCount} Usuários'),
                            subtitle: Divider(height: 0.0),
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: search.items.length,
                              itemBuilder: (_, index) {
                                final user = search.items[index];
                                return UserItemWidget(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                      '/user',
                                      arguments: user.login,
                                    );
                                  },
                                  login: user.login,
                                  avatarUrl: user.avatarUrl,
                                  htmlUrl: user.htmlUrl,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
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
