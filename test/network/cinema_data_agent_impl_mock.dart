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

class CinemaDataAgentImplMock extends CinemaDataAgent {
  @override
  Future<List<CardVO>?> addCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc) {
    // TODO: implement addCard
    throw UnimplementedError();
  }

  @override
  Future<UserBookingVO?> checkOut(String token, CheckOutVO checkOut) {
    //return Future.value(getMockCheckOut);
    // TODO: implement addCard
    throw UnimplementedError();
  }

  @override
  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(String token, int movieId, String date) {
    // TODO: implement getCinemaDayTimeSlots
    throw UnimplementedError();
  }

  @override
  Future<List<List<SeatsVO>>?> getCinemaSeatingPlan(String token, int timeSlotId, String date) {
    // TODO: implement getCinemaSeatingPlan
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    // TODO: implement getComingSoonMovies
    throw UnimplementedError();
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    // TODO: implement getCreditsByMovie
    throw UnimplementedError();
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    // TODO: implement getNowPlayingMovies
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethods(String token) {
    // TODO: implement getPaymentMethods
    throw UnimplementedError();
  }

  @override
  Future<UserVO?> getProfile(String token) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<List<SnacksVO>?> getSnacks(String token) {
    // TODO: implement getSnacks
    throw UnimplementedError();
  }

  @override
  Future<List> logInWithEmail(String email, String password) {
    // TODO: implement logInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<List> logInWithFacebook(String facebookToken) {
    // TODO: implement logInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<List> logInWithGoogle(String googleToken) {
    // TODO: implement logInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }

  @override
  Future<String?> userLogOut(String token) {
    // TODO: implement userLogOut
    throw UnimplementedError();
  }
  
}