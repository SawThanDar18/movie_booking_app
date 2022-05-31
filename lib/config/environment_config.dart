class EnvironmentConfig {
  static const String CONFIG_THEME_COLOR = String.fromEnvironment(
      "CONFIG_THEME_COLOR",
      defaultValue: "MOVIE_APP_COLOR");
  static const String CONFIG_TITLE =
      String.fromEnvironment("CONFIG_TITLE", defaultValue: "MOVIE_APP_TITLE");
  static const String CONFIG_LOGO =
      String.fromEnvironment("CONFIG_LOGO", defaultValue: "MOVIE_APP_LOGO");
  static const String CONFIG_WIDGET_HOME_PAGE_MOVIES = String.fromEnvironment(
      "CONFIG_WIDGET_HOME_PAGE_MOVIES",
      defaultValue: "MOVIE_APP");
  static const String CONFIG_WIDGET_ACTORS =
      String.fromEnvironment("CONFIG_WIDGET_ACTORS", defaultValue: "MOVIE_APP");
  static const String CONFIG_WIDGET_SEAT_NAME = String.fromEnvironment(
      "CONFIG_WIDGET_SEAT_NAME",
      defaultValue: "MOVIE_APP");
  static const String CONFIG_WIDGET_CARDS =
      String.fromEnvironment("CONFIG_WIDGET_CARDS", defaultValue: "MOVIE_APP");
}

///Galaxy app
///flutter run --dart-define=CONFIG_THEME_COLOR=GALAXY_APP_COLOR --dart-define=CONFIG_TITLE=GALAXY_APP_TITLE --dart-define=CONFIG_LOGO=GALAXY_APP_LOGO --dart-define=CONFIG_WIDGET_HOME_PAGE_MOVIES=GALAXY_APP --dart-define=CONFIG_WIDGET_ACTORS=GALAXY_APP --dart-define=CONFIG_WIDGET_SEAT_NAME=GALAXY_APP --dart-define=CONFIG_WIDGET_CARDS=GALAXY_APP

///Movie app
///flutter run --dart-define=CONFIG_THEME_COLOR=MOVIE_APP_COLOR --dart-define=CONFIG_TITLE=MOVIE_APP_TITLE --dart-define=CONFIG_LOGO=MOVIE_APP_LOGO --dart-define=CONFIG_WIDGET_HOME_PAGE_MOVIES=MOVIE_APP --dart-define=CONFIG_WIDGET_ACTORS=MOVIE_APP --dart-define=CONFIG_WIDGET_SEAT_NAME=MOVIE_APP --dart-define=CONFIG_WIDGET_CARDS=MOVIE_APP
