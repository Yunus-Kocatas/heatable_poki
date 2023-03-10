import 'package:dio/dio.dart';

import '../../config/paginationFilter.dart';
import '../../model/errorResponse.dart';
import '../../model/pokemonInfo.dart';
import '../../model/pokemonResponse.dart';

class PokemonDs {
  final Dio _dio;

  PokemonDs(this._dio);

  Future fetchNewListPokemon(PaginationFilter filter) async {
    try {
      var response = await _dio.get('/pokemon', queryParameters: {
        'limit': filter.limit,
        'offset': filter.page * filter.limit
      });
      if (response.statusCode == 200) {
        return PokemonResponse.fromJson(response.data, filter.page);
      } else {
        return ErrorResponse(
            statusCode: response.statusCode ?? 0,
            message: response.statusMessage ?? "");
      }
    } catch (e) {
      return ErrorResponse(statusCode: 0, message: "Try again please");
    }
  }

  Future fetchAPokemonInfo(String name) async {
    try {
      var response = await _dio.get('/pokemon/' + name);
      if (response.statusCode == 200) {
        return PokemonInfo.fromJson(response.data);
      } else {
        return ErrorResponse(
            statusCode: response.statusCode ?? 0,
            message: response.statusMessage ?? "");
      }
    } catch (e) {
      return ErrorResponse(statusCode: 0, message: "Try again please");
    }
  }
}
