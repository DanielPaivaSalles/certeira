import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/empresa_model.dart';
import '../../../core/constants.dart';

class EmpresasController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  List<EmpresaModel> allEmpresas = [];
  List<EmpresaModel> filteredEmpresas = [];
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  EmpresasController() {
    searchController.addListener(_onSearchChanged);
  }

  Future<void> loadEmpresas() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = Uri.parse(ApiRoutes.empresas);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        allEmpresas = data.map((json) => EmpresaModel.fromJson(json)).toList();
        filteredEmpresas = List.from(allEmpresas);

        notifyListeners();
      } else {
        _errorMessage = 'Erro ao carregar empresas: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Erro inesperado: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
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
