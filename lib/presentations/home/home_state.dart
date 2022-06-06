import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  final String lastValue;

  HomeSuccessState(this.lastValue);

  @override
  List<Object?> get props => [lastValue];
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}