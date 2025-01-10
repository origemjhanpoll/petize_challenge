import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/widget/user_widget.dart';

class UserPage extends StatefulWidget {
  final UserCubit cubit;
  const UserPage({super.key, required this.cubit});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserCubit cubit;
  @override
  void initState() {
    cubit = widget.cubit;
    cubit.load(user: 'origemjhanpoll');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(backgroundColor: theme.colorScheme.primaryContainer),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => cubit,
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.isLoaded) {
                final user = state.user;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserWidget(
                        name: user.name,
                        user: user.login,
                        avatarUrl: user.avatarUrl,
                        bio: user.bio,
                        company: user.company,
                        location: user.location,
                        email: user.email,
                        site: user.blog,
                        twitterUsername: user.twitterUsername,
                      )
                    ],
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
        ),
      ),
    );
  }
}
