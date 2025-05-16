import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialSearchEvent extends SearchEvent {}

final class OnSearchEvent extends SearchEvent {
  final String keyword;

  OnSearchEvent(this.keyword);

  @override
  // TODO: implement props
  List<Object?> get props => [keyword];
}
