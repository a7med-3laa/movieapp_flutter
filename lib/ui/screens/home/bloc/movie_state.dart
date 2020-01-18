import 'package:movieapp/data/pojo/MovieResponse.dart';

abstract class MovieState {
//  @override
  List<Object> get props => [];
}

class FetchingMovies extends MovieState {
//  @override
  List<Object> get props => [];
}

class InitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class IgnoreState extends MovieState {
  @override
  List<Object> get props => [];
}

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
