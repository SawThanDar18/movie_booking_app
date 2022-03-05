import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class CardDao {
  
  static final CardDao _singleton = CardDao._internal();

  factory CardDao() {
    return _singleton;
  }

  CardDao._internal();

  Stream<void> getAllCardEventStream() {
    return getCardBox().watch();
  }

  Stream<List<CardVO>> getCardStream() {
    return Stream.value(getAllCards().toList());
  }

  void saveAllCards(List<CardVO>? cardList) async {
    Map<int, CardVO> cardMap = Map.fromIterable(cardList ?? [], key: (card) => card.id, value: (card) => card);
    await getCardBox().putAll(cardMap);
  }

  List<CardVO> getAllCards() {
    return getCardBox().values.toList();
  }

  Box<CardVO> getCardBox() {
    return Hive.box<CardVO>(BOX_NAME_CARD_VO);
  }

}