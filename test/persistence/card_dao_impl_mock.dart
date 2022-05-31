import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/persistence/daos/card_dao.dart';

import '../mock_data/mock_data.dart';

class CardDaoImplMock extends CardDao {
  Map<String, CardVO> cardListFromDatabaseMock = {};

  @override
  Stream<void> getAllCardEventStream() {
    return Stream.value(null);
  }

  @override
  List<CardVO> getAllCards() {
    return cardListFromDatabaseMock.values.toList();
  }

  @override
  Stream<List<CardVO>> getCardStream() {
    return Stream.value(getMockCardList());
  }

  @override
  void saveAllCards(List<CardVO>? cardList) {
    cardList?.forEach((card) {
      cardListFromDatabaseMock[card.id.toString()] = card;
    });
  }

}