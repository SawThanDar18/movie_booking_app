import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';

import '../../hive_constants.dart';

class ActorDaoImpl extends ActorDao {

  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl() {
    return _singleton;
  }

  ActorDaoImpl._internal();

  @override
  Stream<void> getAllActorsEventStream() {
    return getActorBox().watch();
  }

  @override
  Stream<List<ActorVO>> getActorStream() {
    return Stream.value(getAllActors().toList());
  }

  @override
  List<ActorVO> getActors() {
    if ((getAllActors().isNotEmpty)) {
      return getAllActors()
          .toList();
    } else {
      return [];
    }
  }

  @override
  void saveAllActors(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
        key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getAllActors() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

}