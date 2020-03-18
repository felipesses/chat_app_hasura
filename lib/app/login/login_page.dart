import 'package:flutter/material.dart';

import 'login_bloc.dart';
import 'login_module.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = LoginModule.to.bloc<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: bloc.user_controller,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            RaisedButton(
              child: Text("Entrar"),
              onPressed: () {
                bloc.login();
              },
            )
          ],
        ),
      ),
    );
  }
}
