import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shoppies/adapter/auth/authentication_adapter.dart';
import 'package:shoppies/adapter/auth/remote_authentication_adapter.dart';
import 'package:shoppies/bloc/auth/authentication_bloc.dart';
import 'package:shoppies/bloc/bloc/oauth_bloc.dart';
import 'package:shoppies/bloc/catalog/bloc.dart';
import 'package:shoppies/bloc/login/bloc.dart';
import 'package:shoppies/data/database.dart';
import 'package:shoppies/data/repository/authentication_repository.dart';
import 'package:shoppies/ui/cart/cart_screen.dart';
import 'package:shoppies/ui/catalog/catalog_screen.dart';
import 'package:shoppies/ui/login/login_screen.dart';

GetIt appLocator = GetIt.instance;

void _setupLocator() async {
  appLocator.registerSingleton<AppDatabase>(
      await $FloorAppDatabase.databaseBuilder("shoopies").build());
  appLocator.registerSingleton<AuthenticationRepository>(
      appLocator.get<AppDatabase>().authRepository);
  appLocator.registerSingleton<AuthenticationAdapter>(
      new RemoteAuthenticationAdapter());
  appLocator.registerSingleton<AuthenticationBloc>(
      new AuthenticationBloc(repository: appLocator.get()));
  appLocator.registerSingleton<LoginBloc>(new LoginBloc(
      authenticationAdapter: appLocator.get(),
      authenticationBloc: appLocator.get()));
  appLocator.registerSingleton<CatalogBloc>(new CatalogBloc());
  appLocator.registerSingleton<OauthBloc>(
      new OauthBloc(authenticationBloc: appLocator.get()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await _setupLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => appLocator.get<AuthenticationBloc>(),
      ),
      BlocProvider<LoginBloc>(
        create: (BuildContext context) => appLocator.get<LoginBloc>(),
      ),
      BlocProvider<CatalogBloc>(
        create: (BuildContext context) => appLocator.get<CatalogBloc>(),
      ),
      BlocProvider<OauthBloc>(
        create: (BuildContext context) => appLocator.get<OauthBloc>(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoopies',
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale("id"), const Locale("en")],
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Color.fromRGBO(0, 206, 201, 1.0),
          primaryColorLight: Color.fromRGBO(129, 236, 236, 1.0)),
      routes: {
        "login": (context) => LoginScreen(),
        "catalog": (context) => CatalogScreen(),
        "cart": (context) => CartScreen()
      },
      initialRoute: "login",
    );
  }
}
