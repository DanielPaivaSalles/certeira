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

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        allEmpresas =
            data
                .map(
                  (json) => EmpresaModel(
                    codigo: json['codigo'] ?? '',
                    razao: json['razao'] ?? '',
                    fantasia: json['fantasia'] ?? '',
                    cnpj: json['cnpj'] ?? '',
                    im: json['im'] ?? '',
                    codigoEndereco: json['codigoEndereco'] ?? '',
                    dataCadastro: json['dataCadastro'] ?? '',
                    dataDesativado: json['dataDesativado'] ?? '',
                    endereco: json['endereco'] ?? '',
                  ),
                )
                .toList();

        filteredEmpresas = List.from(allEmpresas);
        notifyListeners();
      } else {
        print('Erro ao carregar empresas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar empresas: $e');
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
                (empresa.endereco?['cidade']?.toLowerCase() ?? '').contains(
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
