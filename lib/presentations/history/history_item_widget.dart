import 'package:flutter/material.dart';
import 'package:riadh_pfe/models/history.dart';
import 'package:riadh_pfe/utils/date_formatter.dart';

class HistoryItemWidget extends StatelessWidget {
  final HistoryItem historyItem;

  const HistoryItemWidget({Key? key, required this.historyItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(historyItem.value.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
            ,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(DateFormatter.parseTimeStamp(historyItem.timestamp),
            ),
          )
        ],
      ));
  }


}