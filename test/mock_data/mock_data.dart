import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';

List<CheckOutVO> getMockCheckOut() {
  return [
    CheckOutVO(13, "A", "A-2,A-3", "2022-04-24", 4, 335787, 2, 1, [
     SnacksVO(1, "PopCorn", "Delicious", 2, null),
    ]),
  ];
}