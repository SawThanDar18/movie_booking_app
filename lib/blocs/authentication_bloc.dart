import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/network/responses/error_response.dart';
import 'package:movie_booking_app/pages/home_page.dart';

class AuthenticationBloc extends ChangeNotifier{

  CinemaModel cinemaModel = CinemaModelImpl();

  late String successMsg;
  late BuildContext context;
  String? name;
  String? email;
  String? googleToken;
  String? facebookToken;

  _navigateToHomePage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  _showToast(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  showErrorAlert(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  handleError(BuildContext context, dynamic error) {
    if (error is DioError) {
      try {
        ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
        showErrorAlert(context, errorResponse.message.toString());
      } on Error catch (e) {
        showErrorAlert(context, e.toString());
      }
    } else {
      showErrorAlert(context, error.toString());
    }
  }

  _registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) {
    cinemaModel
        .registerWithEmail(name, email, phoneNumber, password, googleAccessToken, facebookAccessToken)
        .then((successMsg) {
     this.successMsg = successMsg ?? "";
      _navigateToHomePage(context);
    }).catchError((error) {
      handleError(context, error);
    });
  }

  _logInWithEmail(String email, String password) {
    cinemaModel.logInWithEmail(email, password).then((successMsg) {
      _showToast("LogIn Successful!");
      _navigateToHomePage(context);
    }).catchError((error) {
      handleError(context, error);
    });

    _registerWithFacebook() async {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
          name = userData["name"].toString();
          email = userData["email"].toString();
          facebookToken = loginResult.accessToken?.userId;
          print("FacebookUserName>>> ${userData["name"].toString()}");
      } else {
        print("LoginStatus>>> ${loginResult.status}");
        print("Message>>>> ${loginResult.message}");
      }
    }

    _logInWithFacebook() {
      cinemaModel.logInWithFacebook(facebookToken ?? "")
          .then((user) {
        if (user != null) {
          _navigateToHomePage(context);
        }
      }).catchError((error) => debugPrint(error.toString()));
    }


  }
}