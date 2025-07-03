class ApiRoutes {
  //Path base do servidor
  static const String baseUrl = 'http://localhost:8080';

  //Endpoint listagem
  //Empresas
  static const String empresas = '$baseUrl/empresas';

  //Endpoint específico
  //Empresa
  static String get empresa => '$baseUrl/empresa';

  //Login
  static String get empregadosLogin => '$baseUrl/empregadoLogin';
}
