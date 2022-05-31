import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';

///Theme Color
Map<String, dynamic> THEME_COLOR = {
  "GALAXY_APP_COLOR": SPLASH_SCREEN_BACKGROUND_COLOR,
  "MOVIE_APP_COLOR": MOVIE_APP_THEME_COLOR,
};

///Logo
Map<String, String> LOGO = {
  "GALAXY_APP_LOGO": GALAXY_APP_LOGO,
  "MOVIE_APP_LOGO": MOVIE_APP_LOGO,
};

Map<String, String> TITLE = {
  "GALAXY_APP_TITLE": SPLASH_PAGE_HELLO_TEXT,
  "MOVIE_APP_TITLE": SPLASH_PAGE_HELLO_TEXT_MOVIE_APP,
};

Map<String, bool> WIDGET_HOME_PAGE_MOVIES = {
  "GALAXY_APP": true,
  "MOVIE_APP": false,
};

Map<String, bool> WIDGET_ACTORS = {
  "GALAXY_APP": true,
  "MOVIE_APP": false,
};

Map<String, bool> WIDGET_SEAT_NAME = {
  "GALAXY_APP": true,
  "MOVIE_APP": false,
};

Map<String, bool> WIDGET_CARDS = {
  "GALAXY_APP": true,
  "MOVIE_APP": false,
};
