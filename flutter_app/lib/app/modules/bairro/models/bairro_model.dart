class BairroModel {
  final String codigo;
  final String bairro;
  final String dataCadastro;

  BairroModel({this.codigo = '', this.bairro = '', this.dataCadastro = ''});

  factory BairroModel.fromJson(Map<String, dynamic> json) {
    return BairroModel(
      codigo: json['codigo']?.toString() ?? '',
      bairro: json['bairro'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'bairro': bairro, 'dataCadastro': dataCadastro};
  }
}
