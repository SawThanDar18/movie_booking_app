import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';

abstract class ActorDao {


  Stream<void> getAllActorsEventStream();

  Stream<List<ActorVO>> getActorStream();

  List<ActorVO> getActors();

  void saveAllActors(List<ActorVO> actorList);

  List<ActorVO> getAllActors();

}