import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class LoadHistoryEvent extends HistoryEvent {
  @override
  List<Object> get props => [];
}