import 'package:dio/dio.dart' as dio;

import '../entities/user.dart';

// for while, use a local client
final client = dio.Dio();

class UsersService {
  static String baseUrl = 'https://randomuser.me/api';

  static Future<User> getRandom() async {
    final dio.Response response = await client.get('${UsersService.baseUrl}?results=1');

    final Map<String, dynamic> userJson = response.data['results'][0];

    return User.fromJson(userJson);
  }
}
