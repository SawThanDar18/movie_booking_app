import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/persistence/daos/card_dao.dart';

import '../../hive_constants.dart';

class CardDaoImpl extends CardDao {
  static final CardDaoImpl _singleton = CardDaoImpl._internal();

  factory CardDaoImpl() {
    return _singleton;
  }

  CardDaoImpl._internal();

  @override
  Stream<void> getAllCardEventStream() {
    return getCardBox().watch();
  }

  @override
  Stream<List<CardVO>> getCardStream() {
    return Stream.value(getAllCards().toList());
  }

  @override
  void saveAllCards(List<CardVO>? cardList) async {
    Map<int, CardVO> cardMap = Map.fromIterable(cardList ?? [], key: (card) => card.id, value: (card) => card);
    await getCardBox().putAll(cardMap);
  }

  @override
  List<CardVO> getAllCards() {
    return getCardBox().values.toList();
  }

  Box<CardVO> getCardBox() {
    return Hive.box<CardVO>(BOX_NAME_CARD_VO);
  }
}