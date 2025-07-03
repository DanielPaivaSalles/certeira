import 'dart:convert';
import 'package:flutter_app/app/core/constants.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
import 'package:http/http.dart' as http;

class EmpresaController {
  /// Cria ou atualiza empresa
  Future<bool> salvarEmpresa(EmpresaModel empresa) async {
    try {
      // Monta o corpo JSON
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
        // Novo cadastro → POST
        response = await http.post(
          Uri.parse(ApiRoutes.empresas),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      } else {
        // Atualização → PUT
        response = await http.put(
          Uri.parse("${ApiRoutes.empresas}/${empresa.codigo}"),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      }

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Erro ao salvar empresa: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao salvar empresa: $e");
      return false;
    }
  }
}
