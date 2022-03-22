import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class UserDao {

  static final UserDao _singleton = UserDao._internal();

  factory UserDao() {
    return _singleton;
  }

  UserDao._internal();

  Stream<void> getAllUsersEventStream() {
    return getUserBox().watch();
  }

  Stream<List<UserVO>> getUsersStream() {
    return Stream.value(getUsers().toList());
  }

  String? getUserToken() {
    if (getUsers().isNotEmpty) {
      return getUsers()[0].token;
    }
  }

  List<UserVO> getUsers() {
    if ((getAllUsers().isNotEmpty)) {
      return getAllUsers().toList();
    } else {
      return [];
    }
  }

  void saveUsers(UserVO user) async {
    return getUserBox().put(user.id, user);
  }

  List<UserVO> getAllUsers() {
    return getUserBox().values.toList();
  }

  Future<void> deleteUsers() {
    return getUserBox().clear();
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }

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