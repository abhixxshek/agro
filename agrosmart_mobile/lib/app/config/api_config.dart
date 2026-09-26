class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1'; // Android emulator localhost
  static const String openWeatherApiKey = '9736d84f2b387d052f9dfbfaea880970';
  static const String openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

  // Auth endpoints
  static const String loginEndpoint = '/auth/login';
  static const String signupEndpoint = '/auth/signup';
  static const String profileEndpoint = '/auth/profile';

  // ML & Recommendation endpoints
  static const String cropRecommendEndpoint = '/ml/crop-recommend';
  static const String fertilizerRecommendEndpoint = '/ml/fertilizer-recommend';
  static const String yieldPredictEndpoint = '/ml/yield-predict';

  // Analytics & Metadata endpoints
  static const String analysisEndpoint = '/analytics/crop-analysis';
  static const String yieldMetadataEndpoint = '/metadata/yield-options';
  static const String analysisMetadataEndpoint = '/metadata/analysis-options';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
