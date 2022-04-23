import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/persistence/daos/card_dao.dart';

class CardDaoImplMock extends CardDao {
  Map<String, CardVO> cardListFromDatabaseMock = {};

  @override
  Stream<void> getAllCardEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<CardVO> getAllCards() {
    return cardListFromDatabaseMock.values.toList();
  }

  @override
  Stream<List<CardVO>> getCardStream() {
    return Stream.value(cardListFromDatabaseMock.values.toList());
  }

  @override
  void saveAllCards(List<CardVO>? cardList) {
    cardList?.forEach((card) {
      //cardListFromDatabaseMock[card.id ?? 0] = card;
    });
  }

}