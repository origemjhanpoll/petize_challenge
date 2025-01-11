import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository_remote.dart';
import 'package:petize_challenge/modules/user/data/services/api/api_client.dart';
import 'package:petize_challenge/modules/user/data/services/local/local_client_service.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/pages/user_page.dart';
import 'package:petize_challenge/utils/network_service.dart';

class UserModule extends Module {
  @override
  void binds(Injector i) {
    i.add<NetworkService>(NetworkService.new);
    i.add<LocalClientService>(LocalClientService.new);
    i.add<ApiClientService>(ApiClientService.new);
    i.add<Repository>(RepositoryRemote.new);
    i.addSingleton<UserCubit>(UserCubit.new,
        config: BindConfig(
          notifier: (bloc) => bloc.stream,
        ));
    i.addSingleton<RepoCubit>(RepoCubit.new,
        config: BindConfig(
          notifier: (bloc) => bloc.stream,
        ));
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => UserPage(
              userCubit: Modular.get(),
              repoCubit: Modular.get(),
            ));
    super.routes(r);
  }
}
