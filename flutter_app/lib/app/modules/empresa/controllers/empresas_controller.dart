import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/empresa_model.dart';
import '../../../core/constants.dart';

class EmpresasController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  List<EmpresaModel> allEmpresas = [];
  List<EmpresaModel> filteredEmpresas = [];

  EmpresasController() {
    searchController.addListener(_onSearchChanged);
  }

  Future<void> loadEmpresas() async {
    try {
      final url = Uri.parse(ApiRoutes.empresas);
      final response = await http.get(url);

      //print('🔵 Status da resposta: ${response.statusCode}');
      //print('🔵 Body da resposta: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        //print('✅ JSON decodificado: $data');

        allEmpresas = data.map((json) => EmpresaModel.fromJson(json)).toList();
        filteredEmpresas = List.from(allEmpresas);

        //print('✅ Total de empresas carregadas: ${filteredEmpresas.length}');
        notifyListeners();
      } else {
        //print('❌ Erro ao carregar empresas: ${response.statusCode}');
      }
    } catch (e) {
      //print('❌ Exceção ao carregar empresas: $e');
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredEmpresas = List.from(allEmpresas);
    } else {
      filteredEmpresas =
          allEmpresas.where((empresa) {
            return empresa.codigo.toLowerCase().contains(query) ||
                empresa.razao.toLowerCase().contains(query) ||
                empresa.fantasia.toLowerCase().contains(query) ||
                empresa.cnpj.toLowerCase().contains(query) ||
                empresa.codigoEndereco.toLowerCase().contains(query) ||
                (empresa.endereco?.cidade?.cidade.toLowerCase() ?? '').contains(
                  query,
                ) ||
                (empresa.endereco?.bairro?.bairro.toLowerCase() ?? '').contains(
                  query,
                ) ||
                (empresa.endereco?.rua?.rua.toLowerCase() ?? '').contains(
                  query,
                );
          }).toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
