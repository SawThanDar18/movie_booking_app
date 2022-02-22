import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/seats_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/dataagents/cinema_data_agent.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/the_movie_api.dart';
import 'package:movie_booking_app/network/the_cinema_api.dart';

class RetrofitCinemaDataAgentImpl extends CinemaDataAgent {
  late TheCinemaApi theCinemaApi;
  late TheMovieApi theMovieApi;

  static RetrofitCinemaDataAgentImpl _singleton =
      RetrofitCinemaDataAgentImpl._internal();

  factory RetrofitCinemaDataAgentImpl() {
    return _singleton;
  }

  RetrofitCinemaDataAgentImpl._internal() {
    final dio = Dio();
    dio.options = BaseOptions(headers: {
      HEADER_ACCEPT: APPLICATION_JSON,
      HEADER_CONTENT_TYPE: APPLICATION_JSON
    });
    theCinemaApi = TheCinemaApi(dio);
    theMovieApi = TheMovieApi(dio);
  }

  @override
  Future<List<dynamic>> registerWithEmail(
      String name,
      String email,
      String phoneNumber,
      String password,
      String googleAccessToken,
      String facebookAccessToken) {
    return theCinemaApi
        .registerWithEmail(name, email, phoneNumber, password,
            googleAccessToken, facebookAccessToken)
        .asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<List<dynamic>> logInWithEmail(String email, String password) {
    return theCinemaApi.logInWithEmail(email, password).asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<List<dynamic>> logInWithGoogle(String googleToken) {
    return theCinemaApi.logInWithGoogle(googleToken).asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<List<dynamic>> logInWithFacebook(String facebookToken) {
    return theCinemaApi.logInWithFacebook(facebookToken).asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<String?> userLogOut(String token) {
    return theCinemaApi
        .userLogOut(token)
        .asStream()
        .map((response) => response.message)
        .first;
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return theMovieApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return theMovieApi
        .getComingSoonMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return theMovieApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return theMovieApi.getMovieDetails(movieId.toString(), API_KEY);
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return theMovieApi
        .getCreditsByMovie(movieId.toString(), API_KEY)
        .asStream()
        .map((getCreditsByMovieResponse) =>
            [getCreditsByMovieResponse.cast, getCreditsByMovieResponse.crew])
        .first;
  }

  @override
  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(
      String token, int movieId, String date) {
    return theCinemaApi
        .getCinemaDayTimeSlots(token, movieId.toString(), date)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<List<SeatsVO>>?> getCinemaSeatingPlan(String token, int timeSlotId, String date) {
    return theCinemaApi.getCinemaSeatingPlan(token, timeSlotId.toString(), date)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<SnacksVO>?> getSnacks(String token) {
    return theCinemaApi.getSnacks(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  Future<List<PaymentVO>?> getPaymentMethods(String token) {
    return theCinemaApi.getPayment(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<UserVO?> getProfile(String token) {
    return theCinemaApi.getProfile(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<CardVO>?> addCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return theCinemaApi.addCard(token, cardNumber, cardHolder, expirationDate, cvc)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<UserBookingVO?> checkOut(String token, CheckOutVO checkOut) {
    return theCinemaApi.checkOut(token, checkOut)
    .then((response) {
      if(response.code == RESPONSE_CODE_SUCCESS) {
        return Future<GetCheckOutResponse>.value(response);
      } else {
        return Future<GetCheckOutResponse>.error(response.message.toString());
      }
    }).asStream()
        .map((response) => response.data)
        .first;
  }




}
