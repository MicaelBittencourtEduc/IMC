import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        //Bind<ISharedRepositoryInterface>((i) => SharedRepository()),
      ];

  @override
  List<Router> get routers => [Router('/', child: (_, args) => HomePage())];
}
