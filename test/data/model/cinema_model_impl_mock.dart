import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';

import '../../mock_data/mock_data.dart';

class CinemaModelImplMock extends CinemaModel {

  @override
  Future<void> addCard(String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(getMockCardList());
  }

  @override
  Future<UserBookingVO?> checkOut(CheckOutVO checkOut) {
    return Future.value(getMockCheckOut());
  }

  @override
  Future<void> deleteUserFromDatabase() {
    return Future.value(null);
  }

  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(null);
  }

  @override
  Stream<List<CardVO>?> getCardsFromDatabase() {
    return Stream.value(null);
  }

  @override
  void getCinemaDayTimeSlots(int movieId, String date) {
    // no need to mock
  }

  @override
  Stream<List<DayTimeSlotsVO>?> getCinemaDayTimeSlotsFromDatabase(int movieId, String date) {
    return Stream.value(getMockCinemaVOList());
  }

  @override
  Future<List?> getCinemaSeatingPlan(int timeSlotId, String bookingDate) {
    return Future.value(getMockMovieSeatList());
  }

  @override
  void getComingSoonMovies(int page) {
    // no need to mock
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase() {
    return Stream.value(getMockMovieListForTest()
        ?.where((movie) => movie.isComingSoon ?? false)
        .toList());
  }

  @override
  void getCreditsByMovie(int movieId) {
    // no need to mock
  }

  @override
  Stream<List<ActorVO>?> getCreditsByMovieFromDatabase(int movieId) {
    return Stream.value(getMockActors().first);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenres() ?? []);
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(getMockGenres() ?? []);
  }

  @override
  void getMovieDetails(int movieId) {
    // no need to mock
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Stream.value(getMockMovieListForTest()?.first);
  }

  @override
  void getNowPlayingMovies(int page) {
    // no need to mock
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Stream.value(getMockMovieListForTest()
        ?.where((movie) => movie.isNowPlaying ?? false)
        .toList());
  }

  @override
  void getPaymentMethods() {
    // no need to mock
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodsFromDatabase() {
    return Stream.value(getMockPaymentMethodList());
  }

  @override
  Future<UserVO?> getProfile() {
    return Future.value(null);
  }

  @override
  void getSnacks() {
    // no need to mock
  }

  @override
  Stream<List<SnacksVO>?> getSnacksFromDatabase() {
    return Stream.value(getMockSnackList());
  }

  @override
  Stream<List<UserVO>> getUsersFromDatabase() {
    return Stream.value(getMockProfile());
  }

  @override
  Future<String?> logInWithEmail(String email, String password) {
    return Future.value(null);
  }

  @override
  Future<String?> logInWithFacebook(String facebookToken) {
    return Future.value(null);
  }

  @override
  Future<String?> logInWithGoogle(String googleToken) {
    return Future.value(null);
  }

  @override
  Future<String?> registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) {
    return Future.value(null);
  }

  @override
  Future<String?> userLogOut() {
    return Future.value(getMockUserResponse().code.toString());
  }

}