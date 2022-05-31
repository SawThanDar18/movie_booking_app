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
import 'package:movie_booking_app/network/dataagents/cinema_data_agent.dart';

import '../mock_data/mock_data.dart';

class CinemaDataAgentImplMock extends CinemaDataAgent {
  @override
  Future<List<CardVO>?> addCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(getMockCardList());
  }

  @override
  Future<UserBookingVO?> checkOut(String token, CheckOutVO checkOut) {
    return Future.value(getMockCheckOut());
  }

  @override
  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(String token, int movieId, String date) {
    return Future.value(getMockCinemaVOList());
  }

  @override
  Future<List<List<SeatsVO>>?> getCinemaSeatingPlan(String token, int timeSlotId, String date) {
    return Future.value(getMockMovieSeatList());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return Future.value(getMockMovieListForTest()
        ?.where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return Future.value(getMockActors());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenres());
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMovieListForTest()?.first);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(getMockMovieListForTest()
        ?.where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethods(String token) {
    return Future.value(getMockPaymentMethodList());
  }

  @override
  Future<UserVO?> getProfile(String token) {
    return Future.value(getMockProfile().first);
  }

  @override
  Future<List<SnacksVO>?> getSnacks(String token) {
    return Future.value(getMockSnackList());
  }

  @override
  Future<List> logInWithEmail(String email, String password) {
    return Future.value(getMockProfile());
  }

  @override
  Future<List> logInWithFacebook(String facebookToken) {
    return Future.value(getMockProfile());
  }

  @override
  Future<List> logInWithGoogle(String googleToken) {
    return Future.value(getMockProfile());
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) {
    return Future.value(getMockProfile());
  }

  @override
  Future<String?> userLogOut(String token) {
    return Future.value(getMockUserResponse().code.toString());
  }
  
}