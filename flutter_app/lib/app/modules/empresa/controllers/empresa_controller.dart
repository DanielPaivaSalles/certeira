import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
import 'package:flutter_app/app/modules/endereco/models/endereco_model.dart';
import 'package:http/http.dart' as http;

class EmpresaController {
  Future<bool> salvarEmpresa({
    required String codigo,
    required String razao,
    required String fantasia,
    required String cnpj,
    required String im,
    required String codigoEndereco,
    required String dataCadastro,
    required String dataDesativado,
    required Map<String, dynamic> endereco,
  }) async {
    try {
      final empresaModel = EmpresaModel(
        codigo: codigo,
        razao: razao,
        fantasia: fantasia,
        cnpj: cnpj,
        im: im,
        codigoEndereco: codigoEndereco,
        dataCadastro: dataCadastro,
        dataDesativado: dataDesativado,
        endereco: EnderecoModel.fromJson(endereco),
      );

      final body = jsonEncode({
        'codigo': empresaModel.codigo,
        'razao': empresaModel.razao,
        'fantasia': empresaModel.fantasia,
        'cnpj': empresaModel.cnpj,
        'im': empresaModel.im,
        'codigoEndereco': empresaModel.codigoEndereco,
        'dataCadastro': empresaModel.dataCadastro,
        'dataDesativado': empresaModel.dataDesativado,
        'endereco': empresaModel.endereco,
      });

      http.Response response;

      if (empresaModel.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.empresaPost),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.empresaPut}/${empresaModel.codigo}'),
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
