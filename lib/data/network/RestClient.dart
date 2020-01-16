import 'package:dio/dio.dart';
import 'package:movieapp/data/pojo/CastResponse.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/data/pojo/movie_details_response.dart';
import 'package:movieapp/data/network/ApiResponse.dart';

import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/data/pojo/trailers_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../constants.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET(MOVIES_PATH)
  Future<MovieResponse> getMovies();

  @GET(MOVIES_DETAILS_PATH)
  Future<MovieDetailsResponse> getMovieDetails(@Path('id') int movieID);

  @GET(MOVIES_TRAILER_PATH)
  Future<TrailersEntity> getTrailers(@Path('id') int movieID);

  @GET(MOVIES_CAST_PATH)
  Future<CastResponse> getCast(@Path('id') int movieID);

  @GET(MOVIES_REVIEW_PATH)
  Future<ReviewResponse> getReviews(@Path('id') int movieID);
}
