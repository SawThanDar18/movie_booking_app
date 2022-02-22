import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class SnacksDao {

  static final SnacksDao _singleton = SnacksDao._internal();

  factory SnacksDao() {
    return _singleton;
  }

  SnacksDao._internal();

  void saveAllSnacks(List<SnacksVO> snacksList) async {
    Map<int, SnacksVO> snackMap = Map.fromIterable(snacksList, key: (snack) => snack.id, value: (snack) => snack);
    await getSnacksBox().putAll(snackMap);
  }

  List<SnacksVO> getAllSnacks() {
    return getSnacksBox().values.toList();
  }

  Box<SnacksVO> getSnacksBox() {
    return Hive.box<SnacksVO>(BOX_NAME_SNACKS_VO);
  }

}