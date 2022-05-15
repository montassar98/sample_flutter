
import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable{

  final bool count;
  final String next;
  final List<HistoryItem> results;

  const HistoryModel({
    required this.count,
    required this.next,
    required this.results,
  });


  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<HistoryItem> itemsList = list.map((e) => HistoryItem.fromJson(e)).toList();
    return HistoryModel(
      count: json['count'],
      next: json['next'],
      results: itemsList,
    );
  }

  @override
  List<Object> get props => [count, next];
}

class HistoryItem extends Equatable{

  final int timestamp;
  final double value;
  final int createdAt;

  const HistoryItem({
    required this.timestamp,
    required this.value,
    required this.createdAt
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      timestamp: json['timestamp'],
      value: json['value'],
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object> get props => [timestamp, value, createdAt];
}