import 'package:dio/dio.dart';
import 'package:movie_discovery_app/App/data/constants/api_config.dart';
import 'package:movie_discovery_app/App/data/exception/dio_exeception.dart';

class ApiProviderDio {
  static ApiProviderDio? apiProviderDio;

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.apiServer,
      sendTimeout: const Duration(seconds: 5000),
      //5s
      receiveTimeout: const Duration(seconds: 5000),
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  ApiProviderDio() {
    // dio.interceptors
    //     .add(PrettyDioLogger(requestBody: true, requestHeader: true));

    // dio.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     final client = HttpClient();
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   },
    // );
  }

  static ApiProviderDio get instance => apiProviderDio ??= ApiProviderDio();

  setBaseToken({token}) {
    dio.options.headers.addAll({"Authorization": "Bearer $token"});
  }

  removeBaseToken() {
    dio.options.headers.remove("Authorization");
  }

  Future<Response?> get(
    String url, {
    dynamic param,
  }) async {
    try {
      Response response = await dio.get(url, queryParameters: param);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Response> fetch(RequestOptions options) async {
    try {
      Response response = await dio.fetch(options);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Response?> post(
    String url, {
    required Map<String, dynamic> jsonData,
    dynamic param,
  }) async {
    try {
      Response response =
          await dio.post(url, data: jsonData, queryParameters: param);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Response?> postWithAuth(
    String url, {
    required Map<String, dynamic> jsonData,
    dynamic param,
  }) async {
    try {
      Response response =
          await dio.post(url, data: jsonData, queryParameters: param);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> postFormRequestWithAuth(
    String url, {
    required Object? jsonData,
    dynamic param,
  }) async {
    try {
      // var headers = {'X-TOKEN': xToken, 'Content-Type': 'multipart/form-data'};
      Response response = await dio.post(
        url,
        data: jsonData,
        queryParameters: param,
      );
      if (response.statusCode == 200) {
        return Map.from(response.data);
      }
      if (response.statusCode == 201) {
        return Map.from(response.data);
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> patchFormRequestWithAuth(
    String url, {
    required Object? jsonData,
    dynamic param,
  }) async {
    try {
      // var headers = {'X-TOKEN': xToken, 'Content-Type': 'multipart/form-data'};
      Response response = await dio.patch(
        url,
        data: jsonData,
        queryParameters: param,
      );
      if (response.statusCode == 200) {
        return Map.from(response.data);
      }
      if (response.statusCode == 201) {
        return Map.from(response.data);
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> getRequestWithAuth(
    String url, {
    dynamic param,
  }) async {
    try {
      Response response = await dio.get(url, queryParameters: param);

      if (response.statusCode == 200) {
        return Map.from(response.data);
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<List<dynamic>> getRequestWithAuth2(
    String url, {
    dynamic param,
  }) async {
    try {
      Response response = await dio.get(url, queryParameters: param);

      if (response.statusCode == 200) {
        return response.data;
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return [];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> postRequestWithAuth(
    String url, {
    required Map<String, dynamic>? jsonData,
    dynamic param,
  }) async {
    try {
      Response response =
          await dio.post(url, data: jsonData, queryParameters: param);
      if (response.statusCode == 200) {
        return Map.from(response.data);
      }
      if (response.statusCode == 201) {
        return Map.from(response.data);
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }

      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }

      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> put({
    required Map<String, dynamic>? jsonData,
    Map<String, dynamic>? headers,
    dynamic param,
    String? url,
  }) async {
    try {
      Response response = await dio.put(
        url!,
        data: jsonData,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: param,
      );
      if (response.statusCode == 200) {
        return Map.from(response.data);
      }
      if (response.statusCode == 201) {
        return Map.from(response.data);
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> putFormData({
    required Object? jsonData,
    Map<String, dynamic>? headers,
    dynamic param,
    required String url,
  }) async {
    try {
      Response response = await dio.put(
        url,
        data: jsonData,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: param,
      );
      if (response.statusCode == 200) {
        return Map.from(response.data);
      }
      if (response.statusCode == 201) {
        return Map.from(response.data);
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }

  Future<Map<String, dynamic>> delete({
    String? url,
    required Map<String, dynamic>? jsonData,
    dynamic param,
  }) async {
    try {
      Response response =
          await dio.delete(url!, data: jsonData, queryParameters: param);
      if (response.statusCode == 200) {
        return response.data is Map<String, dynamic>
            ? Map.from(response.data)
            : {};
        // if (response.data?['status'] == true) {
        //   return Map.from(response.data);
        // } else {
        //   throw Exception(response.data?['message']);
        // }
      } else if (response.statusCode == 204) {
        return {};
        // return {"message": "Data deleted successfully"};
      }
      if (response.statusCode == 401) {
        throw UnAuthorizedException(message: response.data?['message']);
      }
      if (response.statusCode == 400) {
        throw Exception(response.data?['error']);
      }

      if (response.statusCode == 404) {
        throw Exception(response.data?['message']);
      }

      if (response.data?['message'] != null) {
        throw Exception(response.data?['message']);
      }
      return {};
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).message;
    }
  }
}
