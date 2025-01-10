import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/modules/user/data/repositories/user_repository.dart';
import 'package:petize_challenge/modules/user/data/repositories/user_repository_remote.dart';
import 'package:petize_challenge/modules/user/data/services/api/api_client.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/pages/user_page.dart';

class UserModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ApiClient>(ApiClient.new);
    i.add<UserRepository>(UserRepositoryRemote.new);
    i.addSingleton<UserCubit>(UserCubit.new,
        config: BindConfig(
          notifier: (bloc) => bloc.stream,
        ));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => UserPage(cubit: Modular.get()));
    super.routes(r);
  }
}
