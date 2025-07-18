import 'package:flutter_app/app/modules/estado/models/estado_model.dart';

class CidadeModel {
  final String codigo;
  final String cidade;
  final String codigoEstado;
  final String ibge;
  final String dataCadastro;
  final EstadoModel? estado;

  CidadeModel({
    this.codigo = '',
    this.cidade = '',
    this.codigoEstado = '',
    this.ibge = '',
    this.dataCadastro = '',
    this.estado,
  });

  factory CidadeModel.fromJson(Map<String, dynamic> json) {
    return CidadeModel(
      codigo: json['codigo']?.toString() ?? '',
      cidade: json['cidade'] ?? '',
      codigoEstado: json['codigoEstado']?.toString() ?? '',
      ibge: json['ibge'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
      estado:
          json['estado'] != null ? EstadoModel.fromJson(json['estado']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'cidade': cidade,
      'codigoEstado': codigoEstado,
      'ibge': ibge,
      'dataCadastro': dataCadastro,
      'estado': estado?.toJson(),
    };
  }
}
