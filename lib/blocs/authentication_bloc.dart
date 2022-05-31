import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';

class AuthenticationBloc extends ChangeNotifier{

  CinemaModel cinemaModel = CinemaModelImpl();

  UserVO? userVO;

  String? name;
  String? email;
  String? googleToken;
  String? facebookToken;

  AuthenticationBloc();

  Future<String?> registerWithEmail(String name, String email, String phone, String password, String googleToken, String facebookToken) {
    return cinemaModel.registerWithEmail(name, email, phone, password, googleToken, facebookToken);
  }

  Future<String?> loginWithEmail(String email, String password) {
    return cinemaModel.logInWithEmail(email, password);
  }

  void registerWithGoogle() {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        "email",
        "https://www.googleapis.com/auth/contacts.readonly",
      ],
    );

    googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        email = googleAccount.email;
        name = googleAccount.displayName;
        googleToken = googleAccount.id;
        notifyListeners();
      }).catchError((error) => debugPrint(error.toString()));
    }).catchError((error) => debugPrint(error.toString()));
  }

  Future<String?> loginWithGoogle() {
    return GoogleSignIn().signIn().then((value) {
      value?.authentication.then((data) {
          googleToken = data.idToken ?? "";
          email = value.email;
          //print("GoogleToken>>> $googleToken");
        cinemaModel.logInWithGoogle(googleToken ?? "").then((value) {
          print(value);
        }).catchError((error) {
          debugPrint(error.toString());
        });
      }).catchError((error) => debugPrint((error.toString())));
    });

   /* GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        "email",
        "https://www.googleapis.com/auth/contacts.readonly",
      ],
    );

    googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        googleToken = authentication.idToken ?? "";
        email = googleAccount.email;
          return cinemaModel.logInWithGoogle(googleToken);
          }).catchError((error) => debugPrint(error.toString()));
        }).catchError((error) => debugPrint(error.toString()));*/
  }

  void registerWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData(fields: 'email, name');
      name = userData["name"].toString();
      email = userData["email"].toString();
      if (email == "null") {
        email = "";
      }
      facebookToken = loginResult.accessToken?.userId;
      notifyListeners();
      print("FacebookUserName>>> ${userData["name"].toString()}");
      print("FacebookToken>>>> ${loginResult.accessToken.toString()}");
    } else {
      print("LoginStatus>>> ${loginResult.status}");
      print("Message>>>> ${loginResult.message}");
      print("FacebookToken>>>> ${loginResult.accessToken}");
    }
  }

  Future<String?> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData(
          fields: 'email, name');
      print("FacebookUserName>>> ${userData["name"].toString()}");
      print("FacebookToken>>>> ${loginResult.accessToken?.userId.toString()}");
    } else {
      print("LoginStatus>>> ${loginResult.status}");
      print("Message>>>> ${loginResult.message}");
      print("FacebookToken>>>> ${loginResult.accessToken?.userId}");
    }
    cinemaModel.logInWithFacebook(loginResult.accessToken?.userId.toString() ?? "");

    /*final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
        facebookToken = loginResult.accessToken?.userId.toString();
        cinemaModel.logInWithFacebook(facebookToken ?? "");
        print("FacebookToken>>> $facebookToken");
    } else {
      print("LoginStatus>>> ${loginResult.status}");
      print("Message>>>> ${loginResult.message}");
    }
  }*/
  }

}