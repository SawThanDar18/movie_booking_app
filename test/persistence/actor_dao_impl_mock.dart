import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';

import '../mock_data/mock_data.dart';

class ActorDaoImplMock extends ActorDao {
  Map<int, ActorVO> actorListFromDatabaseMock = {};

  @override
  Stream<List<ActorVO>> getActorStream() {
    return Stream.value(getMockActors().first);
  }

  @override
  List<ActorVO> getActors() {
    return actorListFromDatabaseMock.values.toList();
  }

  @override
  List<ActorVO> getAllActors() {
    return actorListFromDatabaseMock.values.toList();
  }

  @override
  Stream<void> getAllActorsEventStream() {
    return Stream.value(null);
  }

  @override
  void saveAllActors(List<ActorVO> actorList) {
    actorList.forEach((actor) {
      actorListFromDatabaseMock[actor.id ?? 0] = actor;
    });
  }
  
}