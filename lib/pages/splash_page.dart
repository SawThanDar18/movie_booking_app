import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_booking_app/pages/login_signin_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/label_text_view.dart';
import 'package:movie_booking_app/widgets/welcome_text_view.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/movie_app_logo.PNG',
              alignment: Alignment.center,
            ),
            SizedBox(
              height: SPLASH_PAGE_SIZED_BOX_HEIGHT_20,
            ),
            Center(
              child: WelcomeTextView(Colors.white),
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_10,
            ),
            Center(
              child: LabelTextView(SPLASH_PAGE_HELLO_TEXT, Colors.white),
            ),
            SizedBox(
              height: SPLASH_PAGE_SIZED_BOX_HEIGHT_130,
            ),
            GestureDetector(
              onTap: () {
                _navigateToLogInPage(
                  context,
                );
              },
              child: Container(
                height: SPLASH_PAGE_CONTAINER_HEIGHT,
                margin: EdgeInsets.all(SPLASH_PAGE_MARGIN_ALL),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(BORDER_RADIUS))),
                child: Center(
                  child: Text(
                    SPLASH_PAGE_GET_STARTED,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SPLASH_PAGE_GET_STARTED_TEXT_SIZE,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_40,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogInPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInSignInPage()));
  }
}
