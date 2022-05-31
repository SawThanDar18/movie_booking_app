import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

abstract class UserDao {

  Stream<void> getAllUsersEventStream();

  Stream<List<UserVO>> getUsersStream();

  String? getUserToken();

  List<UserVO> getUsers();

  void saveUsers(UserVO user);

  List<UserVO> getAllUsers();

  Future<void> deleteUsers();

}

// Stream<String?> getUserTokenStream() {
//   return Stream.value(getUserToken());
// }

// String? getUserToken() {
//   return getUsers()[0].token;
// }
//
// Stream<String?> getUserTokenStream() {
//   return Stream.value( "Bearer + ${getUserToken.toString()}");
// }