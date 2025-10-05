import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login_exercicio/models/post.dart';
import 'package:login_exercicio/shared/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static final AuthController instance = AuthController();
  late SharedPreferences _sharedPreferences;

  Future<bool> login(String username, String password) async {
    http.Response response = await http.post(
      Uri.parse('${AppConstants.baseAuthApiUrl}auth/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );
    print(response.body);
    print(json.decode(response.body)['accessToken']);
    if (response.statusCode == 200) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString(
        'accessToken',
        json.decode(response.body)['accessToken'],
      );
      await _sharedPreferences.setInt(
        'userId',
        json.decode(response.body)['id'],
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString('accessToken');

    print(token);
    if (token == null) {
      return false;
    }

    try {
      print(JwtDecoder.tryDecode(token));
      print(JwtDecoder.getExpirationDate(token));
      print(JwtDecoder.getRemainingTime(token));
      print(JwtDecoder.isExpired(token));
      return !JwtDecoder.isExpired(token);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove('accessToken');
    await _sharedPreferences.clear();
    return true;
  }
  Future<List<Post>> fetchGuideContent() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final token = _sharedPreferences.getString('accessToken');

    if (token == null) {
      throw Exception('Usuário não autenticado. Token ausente.');
    }

    final url = Uri.parse('${AppConstants.baseAuthApiUrl}posts');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', 
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final postListResponse = PostListResponse.fromJson(jsonBody);
      return postListResponse.posts;
    } else {
      throw Exception('Falha ao carregar os tópicos do guia. Código: ${response.statusCode}');
    }
  }
}
