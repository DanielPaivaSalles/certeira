import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/cidade/models/cidade_model.dart';
import 'package:flutter_app/app/modules/estado/models/estado_model.dart';
import 'package:http/http.dart' as http;

class CidadeController {
  Future<bool> salvarCidade({
    required String codigo,
    required String cidade,
    required String codigoEstado,
    required String ibge,
    required String dataCadastro,
    required Map<String, dynamic> estado,
  }) async {
    try {
      final cidadeModel = CidadeModel(
        codigo: codigo,
        cidade: cidade,
        codigoEstado: codigoEstado,
        ibge: ibge,
        dataCadastro: dataCadastro,
        estado: EstadoModel.fromJson(estado),
      );

      final body = jsonEncode({
        'codigo': cidadeModel.codigo,
        'cidade': cidadeModel.cidade,
        'codigoEstado': cidadeModel.codigoEstado,
        'ibge': cidadeModel.ibge,
        'dataCadastro': cidadeModel.dataCadastro,
        'estado': cidadeModel.estado?.toJson(), // ✅ Corrigido aqui
      });

      http.Response response;

      if (cidadeModel.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.cidadePost),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.cidadePut}/${cidadeModel.codigo}'),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      }

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      //print("Erro ao salvar cidade: $e");
      return false;
    }
  }
}
