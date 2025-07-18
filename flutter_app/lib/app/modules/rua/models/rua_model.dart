class RuaModel {
  final String codigo;
  final String rua;
  final String dataCadastro;

  RuaModel({this.codigo = '', this.rua = '', this.dataCadastro = ''});

  factory RuaModel.fromJson(Map<String, dynamic> json) {
    return RuaModel(
      codigo: json['codigo']?.toString() ?? '',
      rua: json['rua'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'rua': rua, 'dataCadastro': dataCadastro};
  }
}
