import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/bairro/models/bairro_model.dart';
import 'package:flutter_app/app/modules/cidade/models/cidade_model.dart';
import 'package:flutter_app/app/modules/endereco/models/endereco_model.dart';
import 'package:flutter_app/app/modules/rua/models/rua_model.dart';
import 'package:http/http.dart' as http;

class EnderecoController {
  Future<bool> salvarEndereco({
    required String codigo,
    required String codigoRua,
    required String numero,
    required String codigoBairro,
    required String codigoCidade,
    required String cep,
    required String dataCadastro,
    required String dataDesativado,
    required Map<String, dynamic> rua,
    required Map<String, dynamic> bairro,
    required Map<String, dynamic> cidade,
  }) async {
    try {
      final enderecoModel = EnderecoModel(
        codigo: codigo,
        codigoRua: codigoRua,
        numero: numero,
        codigoBairro: codigoBairro,
        codigoCidade: codigoCidade,
        cep: cep,
        dataCadastro: dataCadastro,
        dataDesativado: dataDesativado,
        rua: RuaModel.fromJson(rua),
        bairro: BairroModel.fromJson(bairro),
        cidade: CidadeModel.fromJson(cidade),
      );

      final body = jsonEncode({
        'codigo': enderecoModel.codigo,
        'codigoRua': enderecoModel.codigoRua,
        'numero': enderecoModel.numero,
        'codigoBairro': enderecoModel.codigoBairro,
        'codigoCidade': enderecoModel.codigoCidade,
        'cep': enderecoModel.cep,
        'dataCadastro': enderecoModel.dataCadastro,
        'dataDesativado': enderecoModel.dataDesativado,
        'rua': enderecoModel.rua,
        'bairro': enderecoModel.bairro,
        'cidade': enderecoModel.cidade,
      });

      http.Response response;

      if (enderecoModel.codigo.isEmpty) {
        response = await http.post(
          Uri.parse(ApiRoutes.enderecoPost),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        response = await http.put(
          Uri.parse('${ApiRoutes.enderecoPut}/${enderecoModel.codigo}'),
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
