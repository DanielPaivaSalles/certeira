import 'package:flutter_app/app/modules/endereco/models/empresa_model.dart';

class EmpresaModel {
  final String codigo;
  final String razao;
  final String fantasia;
  final String cnpj;
  final String im;
  final String codigoEndereco;
  final String dataCadastroEmpresa;
  final String dataDesativadoEmpresa;
  final EnderecoModel? endereco;

  EmpresaModel({
    this.codigo = '',
    this.razao = '',
    this.fantasia = '',
    this.cnpj = '',
    this.im = '',
    this.codigoEndereco = '',
    this.dataCadastroEmpresa = '',
    this.dataDesativadoEmpresa = '',
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
      dataCadastroEmpresa: json['dataCadastroEmpresa'] ?? '',
      dataDesativadoEmpresa: json['dataDesativadoEmpresa'] ?? '',
      endereco:
          json['endereco'] != null
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
      'dataCadastroEmpresa': dataCadastroEmpresa,
      'dataDesativadoEmpresa': dataDesativadoEmpresa,
      'endereco': endereco?.toJson(),
    };
  }
}
