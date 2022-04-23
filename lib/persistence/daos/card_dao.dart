import 'package:movie_booking_app/data/vos/users/card_vo.dart';

abstract class CardDao {

  Stream<void> getAllCardEventStream();

  Stream<List<CardVO>> getCardStream();

  void saveAllCards(List<CardVO>? cardList);

  List<CardVO> getAllCards();


}