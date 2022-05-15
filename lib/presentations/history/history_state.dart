import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riadh_pfe/models/history.dart';

@immutable
abstract class HistoryState extends Equatable {}

class HistoryLoadingState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistorySuccessState extends HistoryState {
  final HistoryModel history;

  HistorySuccessState(this.history);

  @override
  List<Object?> get props => [history];
}

class HistoryErrorState extends HistoryState {
  final String error;

  HistoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}