import 'package:flutter_app/app/modules/rua/models/rua_model.dart';
import 'package:flutter_app/app/modules/bairro/models/bairro_model.dart';
import 'package:flutter_app/app/modules/cidade/models/cidade_model.dart';

class EnderecoModel {
  final String codigo;
  final String codigoRua;
  final String numero;
  final String codigoBairro;
  final String codigoCidade;
  final String cep;
  final String dataCadastro;
  final String dataDesativado;
  final RuaModel? rua;
  final BairroModel? bairro;
  final CidadeModel? cidade;

  EnderecoModel({
    this.codigo = '',
    this.codigoRua = '',
    this.numero = '',
    this.codigoBairro = '',
    this.codigoCidade = '',
    this.cep = '',
    this.dataCadastro = '',
    this.dataDesativado = '',
    this.rua,
    this.bairro,
    this.cidade,
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      codigo: json['codigo']?.toString() ?? '',
      codigoRua: json['codigoRua'] ?? '',
      numero: json['numero'] ?? '',
      codigoBairro: json['codigoBairro'] ?? '',
      codigoCidade: json['codigoCidade'] ?? '',
      cep: json['cep'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
      dataDesativado: json['dataDesativado'] ?? '',
      rua: json['rua'] != null ? RuaModel.fromJson(json['rua']) : null,
      bairro:
          json['bairro'] != null ? BairroModel.fromJson(json['bairro']) : null,
      cidade:
          json['cidade'] != null ? CidadeModel.fromJson(json['cidade']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'codigoRua': codigoRua,
      'numero': numero,
      'codigoBairro': codigoBairro,
      'codigoCidade': codigoCidade,
      'cep': cep,
      'dataCadastroEndereco': dataCadastro,
      'dataDesativadoEndereco': dataDesativado,
      'rua': rua?.toJson(),
      'bairro': bairro?.toJson(),
      'cidade': cidade?.toJson(),
    };
  }
}
