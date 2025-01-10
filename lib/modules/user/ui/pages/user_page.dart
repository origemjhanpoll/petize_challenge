import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';

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
    cubit.loadUser(user: 'origemjhanpoll');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (_) => cubit,
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.isLoaded) {
              final user = state.user;
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user.login, style: textTheme.displayMedium),
                    Text(user.reposUrl, style: textTheme.bodySmall),
                    Text(
                      'id:${user.id}',
                      textAlign: TextAlign.left,
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            } else if (state.hasError) {
              return Center(
                child: Text(
                  '${state.errorMessage}',
                  style: textTheme.displayMedium,
                ),
              );
            }
            return LimitedBox();
          },
        ),
      ),
    );
  }
}
