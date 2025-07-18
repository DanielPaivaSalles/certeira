import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/estado/models/estado_model.dart';
import 'package:http/http.dart' as http;

class EstadoController {
  Future<bool> salvarEstado({
    required String codigo,
    required String estado,
    required String uf,
    required String dataCadastro,
  }) async {
    try {
      final estadoModel = EstadoModel(
        codigo: codigo,
        estado: estado,
        uf: uf,
        dataCadastro: dataCadastro,
      );

      final body = jsonEncode({
        'codigo': estadoModel.codigo,
        'estado': estadoModel.estado,
        'uf': estadoModel.uf,
        'dataCadastro': estadoModel.dataCadastro,
      });

      http.Response response;

      if (estadoModel.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.estadoPost),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.estadoPut}/${estadoModel.codigo}'),
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
