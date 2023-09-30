import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../enities/get_joke_entity.dart';
import '../repositories/get_joke_repository.dart';

class GetJokeUseCase implements UseCase<GetJokeEntity, GetJokeParams> {
  final GetJokeRepository getTodoRepository;

  GetJokeUseCase(this.getTodoRepository);

  @override
  Future<Either<Failure, GetJokeEntity>> call(GetJokeParams params) async {
    return await getTodoRepository.getJokeList();
  }
}

class GetJokeParams extends Equatable {
  const GetJokeParams();

  @override
  List<Object> get props => [];
}
