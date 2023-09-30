import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../enities/get_joke_entity.dart';

abstract class GetJokeRepository {
  Future<Either<Failure, GetJokeEntity>> getJokeList();
}
