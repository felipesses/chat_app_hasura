import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../app_module.dart';
import '../app_repository.dart';
import 'login_bloc.dart';
import 'login_page.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc(AppModule.to.get<AppRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
