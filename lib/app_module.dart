import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/modules/search/data/repositories/repository.dart';
import 'package:petize_challenge/modules/search/data/repositories/repository_remote.dart';
import 'package:petize_challenge/modules/search/data/services/api/search_api_client_service.dart';
import 'package:petize_challenge/modules/search/data/services/local/search_local_client_service.dart';
import 'package:petize_challenge/modules/search/ui/cubit/search_cubit.dart';
import 'package:petize_challenge/modules/search/ui/page/search_page.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository_remote.dart';
import 'package:petize_challenge/modules/user/data/services/api/api_client.dart';
import 'package:petize_challenge/modules/user/data/services/local/local_client_service.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/pages/user_page.dart';
import 'package:petize_challenge/utils/network_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<NetworkService>(NetworkService.new);
    i.add<SearchLocalClientService>(SearchLocalClientService.new);
    i.add<SearchApiClientService>(SearchApiClientService.new);
    i.add<SearchRepository>(SearchRepositoryRemote.new);
    i.addSingleton<SearchCubit>(SearchCubit.new,
        config: BindConfig(
          notifier: (bloc) => bloc.stream,
        ));
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
    r.child('/', child: (_) => SearchPage(cubit: Modular.get()));
    r.child('/user',
        child: (_) => UserPage(
              userCubit: Modular.get<UserCubit>(),
              repoCubit: Modular.get<RepoCubit>(),
              user: r.args.data,
            ));
    super.routes(r);
  }
}
