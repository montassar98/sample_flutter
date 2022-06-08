import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riadh_pfe/api/datasource.dart';
import 'package:riadh_pfe/presentations/history/history_page.dart';
import 'package:riadh_pfe/presentations/home/home_bloc.dart';
import 'package:riadh_pfe/presentations/home/home_event.dart';
import 'package:riadh_pfe/presentations/home/home_state.dart';
import 'package:riadh_pfe/utils/extensions.dart';

import 'dart:developer' as dev;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  final String title = "Home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(RepositoryProvider.of<UbidotsRepository>(context));
    _homeBloc.add(LoadLastValueEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
        elevation: 0,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60,),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  dev.log("show progress indicator");
                  return const CircularProgressIndicator();
                }
                if (state is HomeSuccessState) {
                  return buildUi(state.lastValue);
                }
                if (state is HomeErrorState) {
                  return Center(
                    child: Text(state.error.toString()),
                  );
                }
                return Container();
              },
            ),
            const Image(image: AssetImage("assets/images/uv_index.png")),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: MaterialButton(
                        minWidth: 140.0,
                        height: 55,
                        color: Colors.green,
                        child: const Text('Refresh',
                            style: TextStyle(fontSize: 16.0, color: Colors.white)),
                        onPressed: () {
                          dev.log("on refresh clicked");
                          _homeBloc.add(LoadLastValueEvent());
                        },
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
                Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: MaterialButton(
                        minWidth: 140.0,
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
            )
          ],
        ),
      ),
    );
  }

  buildUi(String lastValue) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/images/uv_icon.png")),
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
        ),
      ],
    );
  }

  buildCardsState(String lastValue) {
    final double mLastValue = double.parse(lastValue);
    dev.log(mLastValue.toString());
    String color = "#129f47";
    String title = "Low";
    if (mLastValue >= 3.0 && mLastValue < 6.0) {
      //Medium level
      dev.log("medium level");
      color = "#fbcc3e";
      title = "Medium";
    } else if (mLastValue >= 6.0 && mLastValue < 8.0) {
      //high level
      dev.log("high level");
      color = "#f38304";
      title = "High";
    } else if (mLastValue >= 8.0 && mLastValue < 11.0) {
      //very high level
      dev.log("very high level");
      color = "#e44c24";
      title = "Very High";
    } else if (mLastValue >= 11.0) {
      //extremely high level
      color = "#8b63a3";
      title = "Extremely high";
    }

    return Center(
      child: Column(
        children: [
          const Text("current UV state:",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: MaterialButton(
              minWidth: 200.0,
              height: 55,
              color: color.toColor(),
              child: Text(title,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
