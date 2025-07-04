import 'package:flutter_app/app/modules/endereco/models/empresa_model.dart';

class EmpresaModel {
  final String codigo;
  final String razao;
  final String fantasia;
  final String cnpj;
  final String im;
  final String codigoEndereco;
  final String dataCadastro;
  final String dataDesativado;
  final EnderecoModel? endereco;

  EmpresaModel({
    this.codigo = '',
    this.razao = '',
    this.fantasia = '',
    this.cnpj = '',
    this.im = '',
    this.codigoEndereco = '',
    this.dataCadastro = '',
    this.dataDesativado = '',
    this.endereco,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json) {
    return EmpresaModel(
      codigo: json['codigo']?.toString() ?? '',
      razao: json['razao'] ?? '',
      fantasia: json['fantasia'] ?? '',
      cnpj: json['cnpj'] ?? '',
      im: json['im'] ?? '',
      codigoEndereco: json['codigoEndereco']?.toString() ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
      dataDesativado: json['dataDesativado'] ?? '',
      endereco: json['endereco'] != null
          ? EnderecoModel.fromJson(json['endereco'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'razao': razao,
      'fantasia': fantasia,
      'cnpj': cnpj,
      'im': im,
      'codigoEndereco': codigoEndereco,
      'dataCadastro': dataCadastro,
      'dataDesativado': dataDesativado,
      'endereco': endereco?.toJson(),
    };
  }
}
