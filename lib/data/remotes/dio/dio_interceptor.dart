import 'package:dio/dio.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/utils/shared_prefs.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getToken() ?? '';
    options.headers.addAll({
      if (token.isNotEmpty) 'Authentication': 'Bearer $token',
    });
    handler.next(options);
  }

  Future<String?> _getToken() async {
    return SharedPrefs.getString(Constants.authTokenKey);
  }
}
