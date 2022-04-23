import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';
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
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/pages/add_card_page.dart';
import 'package:movie_booking_app/pages/check_out_page.dart';
import 'package:movie_booking_app/pages/cinema_day_time_slot_page.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/login_signin_page.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/pages/seating_chart_page.dart';
import 'package:movie_booking_app/pages/splash_page.dart';
import 'package:movie_booking_app/pages/ticket_page.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets("Movie Booking App Testing", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    
    expect(find.byType(SplashPage), findsOneWidget);
    await tester.tap(find.text(GET_STARTED));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    
    expect(find.byType(LogInSignInPage), findsOneWidget);
    await tester.enterText(find.byKey(const Key(USER_NAME_KEY)), EMAIL);
    await tester.enterText(find.byKey(const Key(PASSWORD_KEY)), PASSWORD);
    await tester.tap(find.text(CONFIRM));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(NOW_PLAYING_MOVIE_NAME), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(NOW_PLAYING_MOVIE_NAME));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(MovieDetailsPage), findsOneWidget);
    expect(find.text(RUN_TIME), findsOneWidget);
    expect(find.text(RATING), findsOneWidget);
    await tester.tap(find.text(GET_YOUR_TICKET));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(CinemaDayTimeSlotPage), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(TIME_SLOTS_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(NEXT));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(SeatingChartPage), findsOneWidget);
    await tester.drag(find.byKey(const Key(SCROLL_BOTTOM_KEY)), const Offset(0, -120));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(SEAT_KEY_1)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(SEAT_KEY_2)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text(TICKET_TOTAL), findsWidgets);
    expect(find.text(SEAT_NAME_LIST), findsWidgets);
    await tester.tap(find.text(BUY_TICKET_FOR));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(CheckOutPage), findsOneWidget);
    await tester.tap(find.byKey(const Key(POPCORN_PRESS_1_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(POPCORN_PRESS_2_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(CARROTS_PRESS_1_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(CARROTS_PRESS_DECREASE_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text(SUB_TOTAL), findsOneWidget);
    await tester.drag(find.byKey(const Key(SCROLL_PAYMENT_KEY)), const Offset(0, -100));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(PAYMENT_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text(PAY_TOTAL));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(PaymentPage), findsOneWidget);
    await tester.tap(find.text(ADD_NEW_CARD));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(AddCardPage), findsOneWidget);
    await tester.enterText(find.byKey(const Key(CARD_NUMBER_KEY)), CARD_NUMBER);
    await tester.enterText(find.byKey(const Key(CARD_HOLDER_KEY)), CARD_HOLDER);
    await tester.enterText(find.byKey(const Key(EXPIRATION_DATE_KEY)), EXPIRATION_DATE);
    await tester.enterText(find.byKey(const Key(CVC_KEY)), CVC);
    await tester.tap(find.text(CONFIRM));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(PaymentPage), findsOneWidget);
    await tester.tap(find.text(PURCHASE));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    
    expect(find.byType(TicketPage), findsOneWidget);
    expect(find.text(ROW), findsWidgets);
    expect(find.text(PRICE), findsWidgets);
    await tester.pumpAndSettle(const Duration(seconds: 3));

  });
}

