import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

class LoginController {
  Future<LoginResponse> fazerLogin(String email, String senha) async {
    try {
      final url = Uri.parse(ApiRoutes.authLogin);

      final resposta = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha, 'tipo': 'empregado'}),
      );

      if (resposta.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(resposta.body));
      } else {
        return LoginResponse(
          status: false,
          mensagem: 'Erro na conexão: ${resposta.statusCode}',
        );
      }
    } catch (e) {
      return LoginResponse(status: false, mensagem: 'Erro inesperado: $e');
    }
  }
}
