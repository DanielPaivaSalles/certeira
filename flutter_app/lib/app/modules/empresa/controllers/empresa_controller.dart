import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
import 'package:flutter_app/app/modules/endereco/models/empresa_model.dart';
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
      final empresa = EmpresaModel(
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
        'codigo': empresa.codigo,
        'razao': empresa.razao,
        'fantasia': empresa.fantasia,
        'cnpj': empresa.cnpj,
        'im': empresa.im,
        'codigoEndereco': empresa.codigoEndereco,
        'dataCadastro': empresa.dataCadastro,
        'dataDesativado': empresa.dataDesativado,
        'endereco': empresa.endereco,
      });

      http.Response response;

      if (empresa.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.empresa),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.empresa}/${empresa.codigo}'),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      }

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
        print("Erro ao salvar empresa: $e");
      return false;
    }
  }
}
