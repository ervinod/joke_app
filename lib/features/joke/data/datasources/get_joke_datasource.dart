import 'dart:convert';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/joke_response_model.dart';

abstract class GetJokeDataSource {
  Future<JokeResponseModel> getTodoList();
}

class GetJokeDataSourceImpl extends GetJokeDataSource {
  final ApiClient client;

  GetJokeDataSourceImpl({required this.client});

  @override
  Future<JokeResponseModel> getTodoList() async {
    final result = await client.get(Uri.parse(ApiConstants.URL_JOKE));

    if (result.statusCode == 200) {
      if (jsonDecode(result.body) != null) {
        if (json.decode(result.body)["joke"] != null) {
          return JokeResponseModel.fromJson(json.decode(result.body));
        } else {
          throw GeneralException();
        }
      } else {
        throw ApiException(message: "Something Went Wrong");
      }
    } else {
      throw ServerException();
    }
  }
}
