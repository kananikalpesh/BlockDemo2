import 'package:dio/dio.dart';
import 'package:movie_discovery_app/App/data/constants/api_config.dart';
import 'package:movie_discovery_app/App/data/provider/api_provider_dio.dart';
import 'package:movie_discovery_app/App/data/exception/dio_exeception.dart';

class HomeScreenRepository {
  Future<Response?> fetchPopulerApi() async {
    try {
      Response? response =
          await ApiProviderDio.instance.get(ApiConfig.populerList, param: {
        'page': 1,
        'type': 'movie',
        's': 'action',
        'apikey': ApiConfig.apiKey,
      });

      // print({"da >>>>>>>>>", response});
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }
}
