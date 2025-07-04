class EnderecoModel {
  final String codigo;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String cep;
  final String dataCadastro;
  final String dataDesativado;

  EnderecoModel({
    this.codigo = '',
    this.rua = '',
    this.numero = '',
    this.bairro = '',
    this.cidade = '',
    this.cep = '',
    this.dataCadastro = '',
    this.dataDesativado = '',
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      codigo: json['codigo']?.toString() ?? '',
      rua: json['rua'] ?? '',
      numero: json['numero'] ?? '',
      bairro: json['bairro'] ?? '',
      cidade: json['cidade'] ?? '',
      cep: json['cep'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
      dataDesativado: json['dataDesativado'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'cep': cep,
      'dataCadastro': dataCadastro,
      'dataDesativado': dataDesativado,
    };
  }
}
