class EstadoModel {
  final String codigo;
  final String estado;
  final String uf;
  final String dataCadastro;

  EstadoModel({
    this.codigo = '',
    this.estado = '',
    this.uf = '',
    this.dataCadastro = '',
  });

  factory EstadoModel.fromJson(Map<String, dynamic> json) {
    return EstadoModel(
      codigo: json['codigo']?.toString() ?? '',
      estado: json['estado'] ?? '',
      uf: json['uf'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'estado': estado,
      'uf': uf,
      'dataCadastro': dataCadastro,
    };
  }
}
