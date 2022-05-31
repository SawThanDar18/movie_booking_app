import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/persistence/daos/snacks_dao.dart';

import '../mock_data/mock_data.dart';

class SnacksDaoImplMock extends SnacksDao {
  Map<int, SnacksVO> snackListFromDatabaseMock = {};

  @override
  List<SnacksVO> getAllSnacks() {
    return getMockSnackList();
  }

  @override
  Stream<void> getAllSnacksEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<List<SnacksVO>> getSnacksStream() {
    return Stream.value(getMockSnackList());
  }

  @override
  void saveAllSnacks(List<SnacksVO> snacksList) {
    snacksList.forEach((snack) {
      snackListFromDatabaseMock[snack.id ?? 0] = snack;
    });
  }
  
}