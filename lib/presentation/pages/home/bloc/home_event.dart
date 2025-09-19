part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  final String filter;
  const HomeEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

final class HomeStarted extends HomeEvent {
  const HomeStarted(super.filter);
}

final class HomeRefresh extends HomeEvent {
  const HomeRefresh(super.filter);
}

final class FilterChanged extends HomeEvent {
  const FilterChanged(super.filter);
}
