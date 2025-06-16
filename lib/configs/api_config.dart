class ApiConfig {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const int timeoutDuration = 30;
}

/// API endpoints
class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh-token';

  // User endpoints
  static const String userProfile = '/users';
}
