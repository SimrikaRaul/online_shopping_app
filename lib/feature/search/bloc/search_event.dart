import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;
  SearchQueryChangedEvent(this.query);
  @override
  List<Object?> get props => [query];
}

class LoadSearchProductsEvent extends SearchEvent {}
