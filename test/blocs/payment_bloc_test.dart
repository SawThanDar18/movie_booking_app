import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/payment_bloc.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Payment Bloc Test", () {
    PaymentBloc? paymentBloc;

    setUp(() {
      paymentBloc = PaymentBloc(CinemaModelImplMock());
    });

    test("Profile Data Test", () {
      expect(paymentBloc?.profile, getMockProfile().first);
    });

    test("Checkout Data Test", () async {
      paymentBloc
          ?.checkout(6, 'E', 'E-1,E-2', '2022-04-30', 17.0, 294793, 2, 2, [
        SnacksVO(2, 'Smoothies', 'Snack Description', 3, null, 1),
      ]);
      await Future.delayed(Duration(milliseconds: 600));
      expect(
        paymentBloc?.userBooking,
        getMockCheckOut(),
      );
    });
  });
}
