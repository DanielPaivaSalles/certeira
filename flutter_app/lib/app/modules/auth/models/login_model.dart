class LoginResponse {
  final bool status;
  final String mensagem;
  final String? token;
  final Map<String, dynamic>? usuario;

  LoginResponse({
    required this.status, 
    required this.mensagem,
    this.token,
    this.usuario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? false,
      mensagem: json['mensagem'] ?? '',
      token: json['token'],
      usuario: json['usuario'],
    );
  }
}
