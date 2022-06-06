import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riadh_pfe/api/datasource.dart';
import 'package:riadh_pfe/presentations/history/history_bloc.dart';
import 'package:riadh_pfe/presentations/home/home_bloc.dart';
import 'package:riadh_pfe/presentations/home/home_page.dart';
import 'package:riadh_pfe/utils/http_cert.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UbidotsRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(UbidotsRepository()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(UbidotsRepository()),
          )
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(),
        ),
      ),
    );
    /*return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const MyHomePage()
    );*/
  }
}


