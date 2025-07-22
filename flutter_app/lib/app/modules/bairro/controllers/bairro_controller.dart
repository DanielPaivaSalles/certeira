import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/bairro/models/bairro_model.dart';
import 'package:http/http.dart' as http;

class BairroController {
  Future<bool> salvarBairro({
    required String codigo,
    required String bairro,
  }) async {
    try {
      final bairroModel = BairroModel(codigo: codigo, bairro: bairro);

      final body = jsonEncode({
        'codigo': bairroModel.codigo,
        'bairro': bairroModel.bairro,
      });

      http.Response response;

      if (bairroModel.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.bairroPost),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.bairroPut}/${bairroModel.codigo}'),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      }

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      //print("Erro ao salvar empresa: $e");
      return false;
    }
  }
}
