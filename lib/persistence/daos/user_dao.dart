import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class UserDao {

  static final UserDao _singleton = UserDao._internal();

  factory UserDao() {
    return _singleton;
  }

  UserDao._internal();

  void saveUsers(UserVO user) async {
    return getUserBox().put(user.id, user);
  }

  List<UserVO> getUsers() {
    return getUserBox().values.toList();
  }

  Future<void> deleteUsers() {
    return getUserBox().clear();
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }

}