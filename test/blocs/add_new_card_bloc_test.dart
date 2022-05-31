import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/add_new_card_bloc.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  AddNewCardBloc addNewCardBloc = AddNewCardBloc(CinemaModelImplMock());

  test('Add New Card Bloc Test', () {
    expect(
        addNewCardBloc.addCard(
            '1234567890123',
            'Saw',
            '08/23',
            '123'),
        completion(equals(getMockCardList())));
  });
}