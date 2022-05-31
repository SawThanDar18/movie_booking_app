import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/persistence/daos/user_dao.dart';

import '../../hive_constants.dart';

class UserDaoImpl extends UserDao {

  static final UserDaoImpl _singleton = UserDaoImpl._internal();

  factory UserDaoImpl() {
    return _singleton;
  }

  UserDaoImpl._internal();

  @override
  Stream<void> getAllUsersEventStream() {
    return getUserBox().watch();
  }

  @override
  Stream<List<UserVO>> getUsersStream() {
    return Stream.value(getUsers().toList());
  }

  @override
  String? getUserToken() {
    if (getUsers().isNotEmpty) {
      return getUsers()[0].token;
    }
  }

  @override
  List<UserVO> getUsers() {
    if ((getAllUsers().isNotEmpty)) {
      return getAllUsers().toList();
    } else {
      return [];
    }
  }

  @override
  void saveUsers(UserVO user) async {
    return getUserBox().put(user.id, user);
  }

  @override
  List<UserVO> getAllUsers() {
    return getUserBox().values.toList();
  }

  @override
  Future<void> deleteUsers() {
    return getUserBox().clear();
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }

}