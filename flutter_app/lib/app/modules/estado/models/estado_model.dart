class EstadoModel {
  final String codigo;
  final String estado;
  final String uf;

  EstadoModel({this.codigo = '', this.estado = '', this.uf = ''});

  factory EstadoModel.fromJson(Map<String, dynamic> json) {
    return EstadoModel(
      codigo: json['codigo']?.toString() ?? '',
      estado: json['estado'] ?? '',
      uf: json['uf'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'estado': estado, 'uf': uf};
  }
}
