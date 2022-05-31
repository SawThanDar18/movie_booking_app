import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/persistence/daos/snacks_dao.dart';

import '../../hive_constants.dart';

class SnacksDaoImpl extends SnacksDao {

  static final SnacksDaoImpl _singleton = SnacksDaoImpl._internal();

  factory SnacksDaoImpl() {
    return _singleton;
  }

  SnacksDaoImpl._internal();

  @override
  Stream<void> getAllSnacksEventStream() {
    return getSnacksBox().watch();
  }

  @override
  Stream<List<SnacksVO>> getSnacksStream() {
    return Stream.value(getAllSnacks().toList());
  }

  @override
  void saveAllSnacks(List<SnacksVO> snacksList) async {
    Map<int, SnacksVO> snackMap = Map.fromIterable(snacksList, key: (snack) => snack.id, value: (snack) => snack);
    await getSnacksBox().putAll(snackMap);
  }

  @override
  List<SnacksVO> getAllSnacks() {
    return getSnacksBox().values.toList();
  }

  Box<SnacksVO> getSnacksBox() {
    return Hive.box<SnacksVO>(BOX_NAME_SNACKS_VO);
  }

}