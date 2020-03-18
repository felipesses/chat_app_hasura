import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';

class HomeBloc extends BlocBase {
  var controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }
}
