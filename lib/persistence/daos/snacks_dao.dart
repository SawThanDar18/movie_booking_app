import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

abstract class SnacksDao {

  Stream<void> getAllSnacksEventStream();

  Stream<List<SnacksVO>> getSnacksStream();

  void saveAllSnacks(List<SnacksVO> snacksList);

  List<SnacksVO> getAllSnacks();

}