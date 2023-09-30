import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/get_joke_repository.dart';
import '../datasources/get_joke_datasource.dart';
import '../models/joke_response_model.dart';

class GetJokeRepositoryImpl implements GetJokeRepository {
  GetJokeRepositoryImpl({
    required this.getJokeDataSource,
    required this.networkInfo,
  });

  final GetJokeDataSource getJokeDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, JokeResponseModel>> getJokeList() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await getJokeDataSource.getTodoList();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(
          ApiFailure(message: e.message),
        );
      } on GeneralException {
        return Left(GeneralFailure());
      } on Exception {
        return Left(GeneralFailure());
      }
    } else {
      return Left(
        InternetFailure(),
      );
    }
  }
}
