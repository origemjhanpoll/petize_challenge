import 'package:flutter_modular/flutter_modular.dart';
import 'package:petize_challenge/modules/user/user_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [UserModule()];

  @override
  void routes(RouteManager r) {
    r.module('/', module: UserModule());
    super.routes(r);
  }
}
