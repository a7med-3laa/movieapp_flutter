import 'package:equatable/equatable.dart';

class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMoviesEvent extends MovieEvent {
  final int pageNumber = 1;
  @override
  List<Object> get props => [pageNumber];
}

class ReFetchMoviesEvent extends MovieEvent {
  final int pageNumber = 1;

  @override
  List<Object> get props => [pageNumber];
}
