import 'package:equatable/equatable.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchingMovies extends MovieState {}

class InitialState extends MovieState {}

class ErrorFetchingMovies extends MovieState {
  final String msg;

  ErrorFetchingMovies(this.msg);

  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'ErrorFetchingMovies{\'msg\': $msg}';
}

class SuccessFetchedMovies extends MovieState {
  final List<Movie> movies;

  SuccessFetchedMovies(this.movies);

  @override
  List<Object> get props => [movies];

  @override
  String toString() => 'FetchMovies {movies:${movies.length}';
}
