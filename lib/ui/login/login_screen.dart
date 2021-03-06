import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppies/bloc/auth/authentication_bloc.dart';
import 'package:shoppies/bloc/auth/bloc.dart';
import 'package:shoppies/bloc/bloc/oauth_bloc.dart';
import 'package:shoppies/bloc/login/bloc.dart';
import 'package:shoppies/bloc/login/login_bloc.dart';
import 'package:shoppies/ui/login/login_model.dart';
import 'package:shoppies/ui/login/login_text_field.dart';

import 'login_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Login loginModel = new Login();
  bool hasError = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            setState(() {
              hasError = false;
              errorMessage = null;
            });
            Navigator.of(context).pushReplacementNamed("catalog");
          }
        }),
        BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginFailure) {
            setState(() {
              hasError = true;
              errorMessage = state.exception.message;
            });
          }
        })
      ],
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return _buildLoginDialog(context);
              },
            )),
      ),
    );
  }

  _buildLoginDialog(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.all(10),
        child: Center(
            child:
                SingleChildScrollView(child: _buildLoginForm(theme, context))));
  }

  Form _buildLoginForm(ThemeData theme, BuildContext context) {
    Widget errorDialog = hasError
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          )
        : Container();
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 155.0,
            child: Image.asset(
              "assets/images/market.png",
              fit: BoxFit.contain,
            ),
          ),
          Text(
            "Shoppies",
            style: theme.textTheme.display1,
          ),
          SizedBox(height: 45.0),
          LoginTextField(
            title: "Username",
            icon: Icons.person,
            onTextSubmitted: (String value) {
              loginModel.username = value;
            },
          ),
          SizedBox(height: 20.0),
          LoginTextField(
              title: "Password",
              icon: Icons.lock,
              asPassword: true,
              onTextSubmitted: (String value) {
                loginModel.password = value;
              }),
          errorDialog,
          SizedBox(height: 20.0),
          _buildLoginButton(context),
          SizedBox(height: 20.0),
          _buildLoginWithAmarbankButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return LoginButton(
      label: "Login",
      onPress: () => _handleAuthentication(context),
    );
  }

  Widget _buildLoginWithAmarbankButton(BuildContext context) {
    return LoginButton(
      label: "Login with amarbank",
      style: LoginButtonStyle(buttonColor: Theme.of(context).primaryColorDark),
      onPress: () => _handleAuthenticationOauth(context),
    );
  }

  _handleAuthentication(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      loginBloc.add(new LoginFlowStarted(
          username: loginModel.username, password: loginModel.password));
    }
  }

  _handleAuthenticationOauth(BuildContext context) {
    final OauthBloc loginBloc = BlocProvider.of<OauthBloc>(context);
    loginBloc.add(new OauthStarted(context));
  }
}
