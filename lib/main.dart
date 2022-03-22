import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/date_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/movies/production_company_vo.dart';
import 'package:movie_booking_app/data/vos/movies/production_country_vo.dart';
import 'package:movie_booking_app/data/vos/movies/spoken_language_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/splash_page.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(SnacksVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());
  Hive.registerAdapter(CinemaDayTimeVOAdapter());
  Hive.registerAdapter(DayTimeSlotsVOAdapter());
  Hive.registerAdapter(TimeSlotsVOAdapter());

  await Hive.openBox<UserVO>(BOX_NAME_USER_VO);
  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<CardVO>(BOX_NAME_CARD_VO);
  await Hive.openBox<SnacksVO>(BOX_NAME_SNACKS_VO);
  await Hive.openBox<PaymentVO>(BOX_NAME_PAYMENT_VO);
  await Hive.openBox<CinemaDayTimeVO>(BOX_NAME_CINEMA_DAY_TIME_VO);
  await Hive.openBox<DayTimeSlotsVO>(BOX_NAME_DAY_TIME_SLOTS_VO);
  await Hive.openBox<TimeSlotsVO>(BOX_NAME_TIME_SLOTS_VO);

  //await Firebase.initializeApp();
  FacebookAuth.instance.webInitialize(
    appId: "307245218136286",
    cookie: true,
    xfbml: true,
    version: '',
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  CinemaModel cinemaModel = CinemaModelImpl();

  UserVO? userVO;
  List<SnacksVO>? snacks;

  @override
  void initState() {

    cinemaModel.getUsersFromDatabase().listen((user) {
      setState(() {
        if (user.isNotEmpty) {
          userVO = user
              .toList()
              .first;
        }
      });
    }).onError((error) => debugPrint(error.toString()));

    cinemaModel.getSnacks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (userVO?.token != null) ? HomePage() : SplashPage(),
    );
  }
}
