class ApiRoutes {
  //Path base do servidor
  static const String baseUrl = 'http://localhost:8080'; //desenvolvimento
  //static const String baseUrl = 'http://localhost:8080'; //produção

  //Login
  static String get authLogin => '$baseUrl/auth/login';

  //Empresas
  //Listagem
  static const String empresas = '$baseUrl/empresas'; //get
  static String get empresaGet => '$baseUrl/empresa/{codigo}'; //get
  static String get empresaPost => '$baseUrl/empresa'; //post
  static String get empresaPut => '$baseUrl/empresa/{codigo}'; //put
  static String get empresaDelete => '$baseUrl/empresa/{codigo}'; //delete
}
