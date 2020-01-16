import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/AppWidgets.dart';
import 'package:movieapp/ui/screens/favourite/bloc/bloc.dart';
import 'package:movieapp/ui/screens/favourite/bloc/favorite_bloc.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_block.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_events.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_state.dart';
import 'package:movieapp/utils/di.dart';
import 'home_item_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieBloc _movieBloc;
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getIt.get<FavoriteBloc>();
    _movieBloc = getIt.get<MovieBloc>();
    _movieBloc.add(FetchMoviesEvent());
  }

  makeMovieFavorite2(Movie movie) {
    _favoriteBloc
        .add(movie.isFavorite ? UnFavoriteMovie(movie) : FavoriteMovie(movie));
  }

  Widget getScreen(MovieState movieState) {
    if (movieState is FetchingMovies) {
      return ProgressBar();
    } else if (movieState is SuccessFetchedMovies)
      return GridView.builder(
        itemCount: movieState.movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.75),
        itemBuilder: (context, index) {
          return HomeItemWidget(
            movieState.movies[index],
            () => makeMovieFavorite2(movieState.movies[index]),
          );
        },
      );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, movieState) {
        return Container(
          width: double.infinity,
          color: AppColors.COLOR_DARK_PRIMARY,
          child: getScreen(movieState),
        );
      },
    );
  }
}
