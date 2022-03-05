import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class ActorDao {

  static final ActorDao _singleton = ActorDao._internal();

  factory ActorDao() {
    return _singleton;
  }

  ActorDao._internal();

  Stream<void> getAllActorsEventStream() {
    return getActorBox().watch();
  }

  Stream<List<ActorVO>> getActorStream() {
    return Stream.value(getAllActors().toList());
  }

  List<ActorVO> getActors() {
    if ((getAllActors().isNotEmpty)) {
      return getAllActors()
          .toList();
    } else {
      return [];
    }
  }

  void saveAllActors(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
    key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }

  List<ActorVO> getAllActors() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

}