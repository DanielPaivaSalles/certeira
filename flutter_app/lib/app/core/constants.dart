class ApiRoutes {
  //Path base do servidor
  static const String baseUrl = 'http://localhost:8080'; //desenvolvimento
  //static const String baseUrl = 'http://localhost:8080'; //produção

  //Login
  static String get authLogin => '$baseUrl/auth/login';

  //Ruas
  static const String ruas = '$baseUrl/ruas'; //get
  static String get ruaGet => '$baseUrl/rua/{codigo}'; //get
  static String get ruaPost => '$baseUrl/rua'; //post
  static String get ruaPut => '$baseUrl/rua/{codigo}'; //put
  static String get ruaDelete => '$baseUrl/rua/{codigo}'; //delete

  //Bairros
  static const String bairros = '$baseUrl/bairros'; //get
  static String get bairroGet => '$baseUrl/bairro/{codigo}'; //get
  static String get bairroPost => '$baseUrl/bairro'; //post
  static String get bairroPut => '$baseUrl/bairro/{codigo}'; //put
  static String get bairroDelete => '$baseUrl/bairro/{codigo}'; //delete

  //Estados
  static const String estados = '$baseUrl/estados'; //get
  static String get estadoGet => '$baseUrl/estado/{codigo}'; //get
  static String get estadoPost => '$baseUrl/estado'; //post
  static String get estadoPut => '$baseUrl/estado/{codigo}'; //put
  static String get estadoDelete => '$baseUrl/estado/{codigo}'; //delete

  //Cidades
  static const String cidades = '$baseUrl/cidades'; //get
  static String get cidadeGet => '$baseUrl/cidade/{codigo}'; //get
  static String get cidadePost => '$baseUrl/cidade'; //post
  static String get cidadePut => '$baseUrl/cidade/{codigo}'; //put
  static String get cidadeDelete => '$baseUrl/cidade/{codigo}'; //delete

  //Enderecos
  static const String enderecos = '$baseUrl/enderecos'; //get
  static String get enderecoGet => '$baseUrl/endereco/{codigo}'; //get
  static String get enderecoPost => '$baseUrl/endereco'; //post
  static String get enderecoPut => '$baseUrl/endereco/{codigo}'; //put
  static String get enderecoDelete => '$baseUrl/endereco/{codigo}'; //delete

  //Empresas
  static const String empresas = '$baseUrl/empresas'; //get
  static String get empresaGet => '$baseUrl/empresa/{codigo}'; //get
  static String get empresaPost => '$baseUrl/empresa'; //post
  static String get empresaPut => '$baseUrl/empresa/{codigo}'; //put
  static String get empresaDelete => '$baseUrl/empresa/{codigo}'; //delete

  //Empregados
  static const String empregados = '$baseUrl/empregados'; //get
  static String get empregadoGet => '$baseUrl/empregado/{codigo}'; //get
  static String get empregadoPost => '$baseUrl/empregado'; //post
  static String get empregadoPut => '$baseUrl/empregado/{codigo}'; //put
  static String get empregadoDelete => '$baseUrl/empregado/{codigo}'; //delete
}
