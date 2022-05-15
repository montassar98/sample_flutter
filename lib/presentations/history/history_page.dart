import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riadh_pfe/api/datasource.dart';
import 'package:riadh_pfe/presentations/history/history_bloc.dart';
import 'package:riadh_pfe/presentations/history/history_event.dart';
import 'package:riadh_pfe/presentations/history/history_item_widget.dart';
import 'package:riadh_pfe/presentations/history/history_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  final String title = "History";

  @override
  State<HistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    dev.log("build history page");
    return BlocProvider<HistoryBloc>(
      create: (context) =>
          HistoryBloc(RepositoryProvider.of<UbidotsRepository>(context))
            ..add(LoadHistoryEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
          elevation: 0,
          title: Text(widget.title),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
          if (state is HistoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HistorySuccessState) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                padding: const EdgeInsets.all(15),
                itemCount: state.history.results.length,
                itemBuilder: (context, index) {
                  final item = state.history.results[index];
                  return HistoryItemWidget(historyItem: item);
                });
          }
          if (state is HistoryErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }

          return Container();
        }),
      ),
    );
  }
}
