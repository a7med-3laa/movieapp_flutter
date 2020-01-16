import 'package:movieapp/data/database/DbService.dart';
import 'package:movieapp/data/network/NetworkService.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import '../utils/di.dart' as di;

class MovieRepository {
  DbService _dbService;
  NetworkService _networkService;
  MovieRepository() {
    _networkService = di.getIt<NetworkService>();
    _dbService = di.getIt<DbService>();
  }

  Future<List<Movie>> fetchMovies({bool fetchFromDb = false}) async {
    if (fetchFromDb) {
      return _dbService.getMovies();
    } else {
      Set<int> movieIds = await _dbService.getMoviesID();
      List<Movie> movies = await _networkService.getMovies();
      for (var movie in movies) {
        movie.isFavorite = movieIds.contains(movie.id);
      }
      return movies;
    }
  }

  Future<void> favouriteMovie(Movie movie) async {
    return _dbService.insertMovie(movie);
  }

  Future<void> unFavouriteMovie(Movie movie) async {
    return _dbService.deleteMovie(movie.id);
  }

  Future<void> clearFavorite() async {
    return _dbService.clearFavorite();
  }
}

var movieRepository = MovieRepository();
