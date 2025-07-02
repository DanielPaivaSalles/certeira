class LoginResponse {
  final bool status;
  final String mensagem;

  LoginResponse({required this.status, required this.mensagem});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? false,
      mensagem: json['mensagem'] ?? '',
    );
  }
}
