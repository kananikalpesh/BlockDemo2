enum Environment { development, production }

class ApiConfig {
  static const String apiServer = "https://jsonplaceholder.typicode.com/";

  static const String apiKey = '7a8cd486';

  static const String developmentBaseUrl = '$apiServer';
  static const String productionBaseUrl = '$apiServer';

  static Environment currentEnvironment = Environment.development;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.development:
        return developmentBaseUrl;
      case Environment.production:
        return productionBaseUrl;
    }
  }

/*X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X*/

  static const String populerList = "https://www.omdbapi.com/";

/*X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X*/
}
