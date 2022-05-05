import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/snacks_bloc.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Snack Page Bloc",(){

    SnacksBloc? snacksBloc;

    setUp((){
      snacksBloc = SnacksBloc(14, CinemaModelImplMock());
    });


    test("Snacks Data Test",(){
      expect(
        snacksBloc?.snacks?.contains(getMockSnackList().first),
        true,
      );
    });

    test("Payment Methods Test",(){
      expect(
        snacksBloc?.paymentMethods?.contains(getMockPaymentMethodList().first),
        true,
      );
    });

    test("Click Payment Methods Test", () async {
      snacksBloc?.onTapPaymentMethod(1);
      expect(
        snacksBloc?.paymentMethods?.first.isSelected,
        true,
      );
    });

    test("Click Decrease Snacks Quantity Test",(){
      snacksBloc?.onTapDecrease(
        SnacksVO(
        1,
        'Popcorns',
        'Snack Description',
        2,
        null,
          1
      ),);
      expect(
        snacksBloc?.snacks?.first.quantity,
        0,
      );
      expect(
        snacksBloc?.subTotal,
        12.0,
      );
    });

    test("Click Increase Snacks Quantity Test",(){
      snacksBloc?.onTapIncrease(
        SnacksVO(
            1,
            'Popcorns',
            'Snack Description',
            2,
            null,
            1
        ),);
      expect(
        snacksBloc?.snacks?.first.quantity,
        2,
      );
      expect(
        snacksBloc?.subTotal,
        16.0,
      );
    });

  });

}