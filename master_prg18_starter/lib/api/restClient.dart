import 'package:dio/dio.dart';
import 'package:master_prg18_starter/commons/config.dart';
import 'package:retrofit/retrofit.dart';

import '../model/response/categorie_list_response.dart';

part 'restClient.g.dart';

@RestApi(baseUrl: '${Config.BASE_URL}/api/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/categories')
  Future<CategorieResponse> getCategories();
}