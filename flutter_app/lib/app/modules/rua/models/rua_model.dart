class RuaModel {
  final String codigo;
  final String rua;

  RuaModel({this.codigo = '', this.rua = ''});

  factory RuaModel.fromJson(Map<String, dynamic> json) {
    return RuaModel(
      codigo: json['codigo']?.toString() ?? '',
      rua: json['rua'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'rua': rua};
  }
}
