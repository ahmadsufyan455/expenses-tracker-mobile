part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeStarted extends HomeEvent {}

final class HomeRefresh extends HomeEvent {}

final class FilterChanged extends HomeEvent {
  final String filter;

  const FilterChanged({required this.filter});

  @override
  List<Object> get props => [filter];
}