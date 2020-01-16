import 'package:equatable/equatable.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class InitialFavoriteState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class GetFavortieMovies extends FavoriteState {
  final List<Movie> movies;

  GetFavortieMovies(this.movies);

  @override
  List<Object> get props => [movies];
}

class LoadingMovies extends FavoriteState {
  @override
  List<Object> get props => [];
}
