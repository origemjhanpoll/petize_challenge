import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/modules/search/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/search/data/repositories/repository.dart';
import 'package:petize_challenge/modules/search/data/services/api/search_api_service.dart';
import 'package:petize_challenge/modules/search/data/services/local/search_local_service.dart';
import 'package:petize_challenge/modules/search/ui/cubit/search_cubit.dart';
import 'package:petize_challenge/modules/search/ui/page/search_page.dart';
import 'package:petize_challenge/modules/user/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/data/services/api/user_api_service.dart';
import 'package:petize_challenge/modules/user/data/services/local/user_local_service.dart';
import 'package:petize_challenge/modules/user/ui/cubit/repo_cubit.dart';
import 'package:petize_challenge/modules/user/ui/cubit/user_cubit.dart';
import 'package:petize_challenge/modules/user/ui/pages/user_page.dart';
import 'package:petize_challenge/modules/user/ui/widget/web_view_app_widget.dart';
import 'package:petize_challenge/utils/network_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<NetworkService>(NetworkService.new);
    i.add<SearchLocalService>(SearchLocalService.new);
    i.add<SearchApiService>(SearchApiService.new);
    i.add<ISearchRepository>(SearchRepository.new);
    i.add<SearchCubit>(SearchCubit.new);
    i.add<UserLocalService>(UserLocalService.new);
    i.add<UserApiService>(UserApiService.new);
    i.add<IUserRepository>(UserRepository.new);
    i.add<UserCubit>(UserCubit.new);
    i.add<RepoCubit>(RepoCubit.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => SearchPage(key: Key('SearchPage'), cubit: Modular.get()));
    r.child(
      '/user/:login',
      child: (_) => UserPage(
        key: Key('UserPage'),
        userCubit: Modular.get<UserCubit>(),
        repoCubit: Modular.get<RepoCubit>(),
        login: r.args.params['login'],
      ),
    );
    r.child('/view',
        child: (_) => WebViewAppWidget(
              key: Key('WebViewAppWidget'),
              title: r.args.data['title'].toString(),
              url: r.args.data['url'].toString(),
            ));

    super.routes(r);
  }
}
