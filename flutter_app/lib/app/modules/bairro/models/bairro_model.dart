class BairroModel {
  final String codigo;
  final String bairro;

  BairroModel({this.codigo = '', this.bairro = ''});

  factory BairroModel.fromJson(Map<String, dynamic> json) {
    return BairroModel(
      codigo: json['codigo']?.toString() ?? '',
      bairro: json['bairro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'bairro': bairro};
  }
}
