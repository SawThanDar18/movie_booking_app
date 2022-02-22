
import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/responses/get_add_card_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_day_time_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_seating_plan_response.dart';
import 'package:movie_booking_app/network/responses/get_payment_response.dart';
import 'package:movie_booking_app/network/responses/get_snacks_list_response.dart';
import 'package:movie_booking_app/network/responses/user_logout_response.dart';
import 'package:movie_booking_app/network/responses/user_response.dart';
import 'package:retrofit/http.dart';

part 'the_cinema_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class TheCinemaApi {

  factory TheCinemaApi(Dio dio) = _TheCinemaApi;

  @POST(ENDPOINT_REGISTER_WITH_EMAIL)
  @FormUrlEncoded()
  Future<UserResponse> registerWithEmail(
      @Field(PARAM_NAME) String name,
      @Field(PARAM_EMAIL) String email,
      @Field(PARAM_PHONE) String phoneNumber,
      @Field(PARAM_PASSWORD) String password,
      @Field(PARAM_GOOGLE_ACCESS_TOKEN) String? googleAccessToken,
      @Field(PARAM_FACEBOOK_ACCESS_TOKEN) String? facebookAccessToken
      );

  @POST(ENDPOINT_LOGIN_WITH_EMAIL)
  @FormUrlEncoded()
  Future<UserResponse> logInWithEmail(
      @Field(PARAM_EMAIL) String email,
      @Field(PARAM_PASSWORD) String password
      );
  
  @POST(ENDPOINT_LOGIN_WITH_GOOGLE)
  @FormUrlEncoded()
  Future<UserResponse> logInWithGoogle(
      @Field(PARAM_ACCESS_TOKEN) String googleToken
      );

  @POST(ENDPOINT_LOGIN_WITH_FACEBOOK)
  @FormUrlEncoded()
  Future<UserResponse> logInWithFacebook(
  @Field(PARAM_ACCESS_TOKEN) String facebookToken
  );

  @POST(ENDPOINT_USER_LOGOUT)
  Future<UserLogOutResponse> userLogOut(
      @Header(KEY_AUTHORIZATION) String token,
      );

  @GET(ENDPOINT_GET_CINEMA_DAY_TIME_SLOTS)
  Future<GetCinemaDayTimeResponse> getCinemaDayTimeSlots(
      @Header(KEY_AUTHORIZATION) String token,
      @Query(PARAM_MOVIE_ID) String movieId,
      @Query(PARAM_DATE) String date
      );

  @GET(ENDPOINT_GET_CINEMA_SEATING)
  Future<GetCinemaSeatingPlanResponse> getCinemaSeatingPlan(
      @Header(KEY_AUTHORIZATION) String token,
      @Query(PARAM_DAY_TIME_ID) String movieId,
      @Query(PARAM_BOOKING_DATE) String date
      );

  @GET(ENDPOINT_GET_SNACKS_LIST)
  Future<GetSnacksListResponse> getSnacks(
      @Header(KEY_AUTHORIZATION) String token,
      );

  @GET(ENDPOINT_GET_PAYMENT)
  Future<GetPaymentResponse> getPayment(
      @Header(KEY_AUTHORIZATION) String token,
      );

  @GET(ENDPOINT_GET_PROFILE)
  @FormUrlEncoded()
  Future<UserResponse> getProfile(
      @Header(KEY_AUTHORIZATION) String token
      );

  @POST(ENDPOINT_ADD_CARD)
  @FormUrlEncoded()
  Future<GetAddCardResponse> addCard(
      @Header(KEY_AUTHORIZATION) String token,
      @Field(PARAM_CARD_NUMBER) String cardNumber,
      @Field(PARAM_CARD_HOLDER) String cardHolder,
      @Field(PARAM_CARD_EXPIRE_DATE) String expirationDate,
      @Field(PARAM_CVC) String cvc,
      );

  @POST(ENDPOINT_GET_CHECKOUT)
  Future<GetCheckOutResponse> checkOut(
      @Header(KEY_AUTHORIZATION) String token,
      @Body() CheckOutVO checkOutVO
      );
}