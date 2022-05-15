import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riadh_pfe/api/datasource.dart';
import 'package:riadh_pfe/presentations/history/history_page.dart';
import 'package:riadh_pfe/presentations/home/home_bloc.dart';
import 'package:riadh_pfe/presentations/home/home_event.dart';
import 'package:riadh_pfe/presentations/home/home_state.dart';

import '../../api/constants.dart';

import 'dart:developer' as dev;


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  final String title = "Home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocProvider(
              create: (context) =>
                  HomeBloc(RepositoryProvider.of<UbidotsRepository>(context))
                    ..add(LoadLastValueEvent()),
              child: BlocBuilder<HomeBloc,HomeState>(builder: (context,state) {
                if(state is LoadLastValueEvent){
                  return const CircularProgressIndicator();
                }
                if(state is HomeSuccessState){
                  return buildUi(state.lastValue);
                }
                if(state is HomeErrorState){
                  return Center(
                    child: Text(state.error.toString()),
                  );
                }
                return Container();
              },)
            ),
            Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 55,
                    color: Colors.green,
                    child: const Text('Refresh',
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    onPressed: () {
                      dev.log("on refresh clicked");
                      HomeBloc(RepositoryProvider.of<UbidotsRepository>(context))
                          .add(LoadLastValueEvent());
                    },
                  ),
                )),
            const SizedBox(height: 20,),
            Center(
                child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: MaterialButton(
                minWidth: 200.0,
                height: 55,
                color: Colors.black87,
                child: const Text('History',
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryPage()),
                  );
                },
              ),
            )),

          ],
        ),
      ),
    );
  }

  buildUi(String lastValue){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Image(
                image:
                AssetImage("assets/images/ic_thermometer.png")),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(lastValue,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent)),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        buildCardsState(lastValue),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }

  buildCardsState(String lastValue) {
    final double mLastValue = double.parse(lastValue);
    if(mLastValue > Constants.dangerValue){
      //Danger zone
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.white.withAlpha(600) ,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/led_green.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Safe zone',
                      style: TextStyle(
                          color: Colors.green, fontSize: 20))
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Image.asset("assets/images/led_red.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Danger zone',
                    style: TextStyle(
                        color: Colors.redAccent, fontSize: 20),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    else {
      return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/led_green.png"),
                const SizedBox(
                  height: 10,
                ),
                const Text('Safe zone',
                    style: TextStyle(
                        color: Colors.green, fontSize: 20))
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white.withAlpha(600),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Image.asset("assets/images/led_red.png"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Danger zone',
                  style: TextStyle(
                      color: Colors.redAccent, fontSize: 20),
                )
              ],
            ),
          ),
        )
      ],
    );
    }
  }
}
