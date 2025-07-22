import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/rua/models/rua_model.dart';
import 'package:http/http.dart' as http;

class RuaController {
  Future<bool> salvarRua({required String codigo, required String rua}) async {
    try {
      final ruaModel = RuaModel(codigo: codigo, rua: rua);

      final body = jsonEncode({'codigo': ruaModel.codigo, 'rua': ruaModel.rua});

      http.Response response;

      if (ruaModel.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.ruaPost),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.ruaPut}/${ruaModel.codigo}'),
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
