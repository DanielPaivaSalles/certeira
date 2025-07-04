class EnderecoModel {
  final String codigo;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String cep;
  final String dataCadastroEndereco;
  final String dataDesativadoEndereco;

  EnderecoModel({
    this.codigo = '',
    this.rua = '',
    this.numero = '',
    this.bairro = '',
    this.cidade = '',
    this.cep = '',
    this.dataCadastroEndereco = '',
    this.dataDesativadoEndereco = '',
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      codigo: json['codigo']?.toString() ?? '',
      rua: json['rua'] ?? '',
      numero: json['numero'] ?? '',
      bairro: json['bairro'] ?? '',
      cidade: json['cidade'] ?? '',
      cep: json['cep'] ?? '',
      dataCadastroEndereco: json['dataCadastroEndereco'] ?? '',
      dataDesativadoEndereco: json['dataDesativadoEndereco'] ?? '',
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
      'dataCadastroEndereco': dataCadastroEndereco,
      'dataDesativadoEndereco': dataDesativadoEndereco,
    };
  }
}
