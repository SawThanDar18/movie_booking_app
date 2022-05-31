import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/seats_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/network/responses/user_response.dart';
import 'package:movie_booking_app/utils/constants.dart';

List<MovieVO>? getMockMovieListForTest() {
  return [
    MovieVO(
      false,
      ' /cTTggc927lEPCMsWUsdugSj6wAY.jpg',
      [28, 12],
      335787,
      'en',
      'Uncharted',
      ' A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother.',
      677.833,
      '/sqLowacltbZLoCa4KYye64RvvdQ.jpg',
      '2022-02-10',
      'Uncharted',
      false,
      7.1,
      903,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      true,
      false,
    ),
    MovieVO(
      false,
      ' /cTTggc927lEPCMsWUsdugSj6wAY.jpg',
      [28, 12],
      335787,
      'en',
      'The Longest Day',
      'World War II movie based on Normandy Landing',
      677.833,
      '/sqLowacltbZLoCa4KYye64RvvdQ.jpg',
      '1952-02-10',
      'The Longest Day',
      false,
      7.1,
      903,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      false,
      true,
    ),
  ];
}

List<List<ActorVO>> getMockActors() {
  return [
    [
      ActorVO(
          false,
          1136406,
          null,
          108.741,
          2,
          'Acting',
          'Tom Holland',
          ' /bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg',
          ' Tom Holland',
          9,
          'Nathan Drake',
          '59233009c3a3683f52001537',
          0),
      ActorVO(
          false,
          13240,
          null,
          36.92,
          2,
          'Acting',
          'Mark Wahlberg',
          ' /bTEFpaWd7A6AZVWOqKKBWzKEUe8.jpg',
          'Mark Wahlberg',
          15,
          ' Victor \'Sully\' Sullivan',
          '5dcca609b76cbb0011735eae',
          1),
      ActorVO(
          false,
          3131,
          null,
          24.828,
          2,
          'Acting',
          ' Antonio Banderas',
          '/uqqgAdPfi1TmG3tfKfhsf20fHE6.jpg',
          'Antonio Banderas',
          27,
          'Santiago Moncada',
          '5e5d5bf566ae4d001289a72f',
          2),
    ],
  ];
}

List<GenreVO>? getMockGenres() {
  return [
    GenreVO(1, 'Action'),
    GenreVO(2, 'Adventure'),
    GenreVO(3, 'Comedy'),
  ];
}

List<UserVO> getMockProfile() {
  return [
    UserVO(
      1,
      'Saw',
      'Saw1998@gmail.com',
      '+959123456789',
      null,
      null,
      [
        CardVO(1, 'Saw', '1234567890123', '08/23', 'JCB', null),
        CardVO(2, 'Juu', '1234567890123', '08/23', 'JCB', null),
      ],
      '5122|I1wOPuUGKiB1UhyiYR5Ep80LgYQzOpnlwOe3vJqz',
    ),
  ];
}

List<DayTimeSlotsVO>? getMockCinemaVOList() {
  return [
    DayTimeSlotsVO(1, 'Cinema I', [
      TimeSlotsVO(1, '10:00 AM'),
      TimeSlotsVO(2, '12:00 PM'),
      TimeSlotsVO(3, '1:00 PM')
    ]),
    DayTimeSlotsVO(2, 'Cinema II', [
      TimeSlotsVO(4, '10:00 AM'),
      TimeSlotsVO(5, '12:00 PM'),
      TimeSlotsVO(6, '1:00 PM')
    ]),
    DayTimeSlotsVO(3, 'Cinema III', [
      TimeSlotsVO(7, '10:00 AM'),
      TimeSlotsVO(8, '12:00 PM'),
      TimeSlotsVO(9, '1:00 PM')
    ]),
  ];
}

CinemaDayTimeVO? getMockCinemaListVO() {
  return CinemaDayTimeVO([
    DayTimeSlotsVO(1, 'Cinema I', [
      TimeSlotsVO(1, '10:00 AM'),
      TimeSlotsVO(2, '12:00 PM'),
      TimeSlotsVO(3, '1:00 PM')
    ]),
    DayTimeSlotsVO(2, 'Cinema II', [
      TimeSlotsVO(4, '10:00 AM'),
      TimeSlotsVO(5, '12:00 PM'),
      TimeSlotsVO(6, '1:00 PM')
    ]),
    DayTimeSlotsVO(3, 'Cinema III', [
      TimeSlotsVO(7, '10:00 AM'),
      TimeSlotsVO(8, '12:00 PM'),
      TimeSlotsVO(9, '1:00 PM')
    ]),
  ]);
}

List<List<SeatsVO>>? getMockMovieSeatList() {
  return [
    [
      SeatsVO(1, SEAT_TYPE_AVAILABLE, 'A1', 'A', 5, false),
      SeatsVO(2, SEAT_TYPE_AVAILABLE, 'A2', 'A', 5, false),
      SeatsVO(3, SEAT_TYPE_AVAILABLE, 'A3', 'A', 5, false),
      SeatsVO(4, SEAT_TYPE_AVAILABLE, 'B1', 'B', 6, false),
      SeatsVO(5, SEAT_TYPE_AVAILABLE, 'B2', 'B', 6, false),
      SeatsVO(6, SEAT_TYPE_AVAILABLE, 'B3', 'B', 6, false)
    ]
  ];
}

List<SeatsVO> getMockMovieSeatingList() {
  return [
    SeatsVO(1, SEAT_TYPE_AVAILABLE, 'A1', 'A', 5, false),
    SeatsVO(2, SEAT_TYPE_AVAILABLE, 'A2', 'A', 5, false),
    SeatsVO(3, SEAT_TYPE_AVAILABLE, 'A3', 'A', 5, false),
    SeatsVO(4, SEAT_TYPE_AVAILABLE, 'B1', 'B', 6, false),
    SeatsVO(5, SEAT_TYPE_AVAILABLE, 'B2', 'B', 6, false),
    SeatsVO(6, SEAT_TYPE_AVAILABLE, 'B3', 'B', 6, false)
  ];
}

List<PaymentVO> getMockPaymentMethodList() {
  return [
    PaymentVO(1, 'Credit Card', 'VISA, JCB'),
    PaymentVO(2, 'Mobile Banking', 'VISA, JCB'),
    PaymentVO(3, 'E-Wallet', 'VISA, JCB'),
  ];
}

List<SnacksVO> getMockSnackList() {
  return [
    SnacksVO(1, 'Popcorns', 'Snack Description', 2, null, 1),
    SnacksVO(2, 'Smoothies', 'Snack Description', 3, null, 1),
    SnacksVO(3, 'Carrots', 'Snack Description', 4, null, 1),
  ];
}

CheckOutVO getMockCheckOutVO() {
  return CheckOutVO(6, 'E', 'E-1,E-2', '2022-04-30', 17.0, 294793, 2, 2, [
    SnacksVO(2, 'Smoothies', 'Snack Description', 3, null, 1),
  ]);
}

UserBookingVO getMockCheckOut() {
  return UserBookingVO(
    720,
    'Cinema II-1234-5678',
    '2022-04-30',
    'E',
    'E-1,E-2',
    2,
    '\$17',
    294793,
    2,
    'Saw',
    TimeSlotsVO(6, '1:00 PM'),
    [
      SnacksVO(2, 'Smoothies', 'Snack Description', 3, null, 1),
    ],
    "",
  );
}

List<CardVO> getMockCardList() {
  return [
    CardVO(1, 'Saw', '1234567890123', '08/23', 'JCB', null),
    CardVO(2, 'Juu', '1234567890123', '08/23', 'JCB', null),
    CardVO(3, 'JC', '1234567890123', '08/23', 'JCB', null),
  ];
}

UserResponse getMockUserResponse() {
  return UserResponse(
    200,
    'Success',
    UserVO(
      1,
      'Saw',
      'Saw1998@gmail.com',
      '+959123456789',
      null,
      null,
      [
        CardVO(1, 'Saw', '1234567890123', '08/23', 'JCB', null),
        CardVO(2, 'Juu', '1234567890123', '08/23', 'JCB', null),
        CardVO(3, 'JC', '1234567890123', '08/23', 'JCB', null),
      ],
      '5122|I1wOPuUGKiB1UhyiYR5Ep80LgYQzOpnlwOe3vJqz',
    ),
    '5122|I1wOPuUGKiB1UhyiYR5Ep80LgYQzOpnlwOe3vJqz',
  );
}
