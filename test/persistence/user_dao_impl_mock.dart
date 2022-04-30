import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/persistence/daos/user_dao.dart';

import '../mock_data/mock_data.dart';

class UserDaoImplMock extends UserDao {
  Map<int, UserVO> profileFromDatabaseMock = {};

  @override
  Future<void> deleteUsers() {
    return Future.value(null);
    //return profileFromDatabaseMock.clear();
  }

  @override
  List<UserVO> getAllUsers() {
    return getMockProfile();
  }

  @override
  Stream<void> getAllUsersEventStream() {
    return Stream.value(null);
  }

  @override
  String? getUserToken() {
    return getMockProfile().first.token;
  }

  @override
  List<UserVO> getUsers() {
    return getMockProfile();
  }

  @override
  Stream<List<UserVO>> getUsersStream() {
    return Stream.value(getMockProfile());
  }

  @override
  void saveUsers(UserVO user) {
    profileFromDatabaseMock[user.id ?? 0] = user;
  }
  
}