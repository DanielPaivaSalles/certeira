<?php

namespace App\Controllers;

use App\Models\EmpregadoModel;
use App\Models\ClienteModel;
use CodeIgniter\RESTful\ResourceController;
use Firebase\JWT\JWT;

class Auth extends ResourceController {
    public function login() {
        $json = $this->request->getJSON(true);

        $tipo = $json['tipo'] ?? '';
        $email = $json['email'] ?? '';
        $senha = $json['senha'] ?? '';

        $tipo = 'empregado';
        $email = 'danielpaivasalles@gmail.com';
        $senha = '530337503b614a@D';

        if (!$tipo || !$email || !$senha) {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Tipo, email ou senha são obrigatórios.'
            ])->setStatusCode(400);
        }

        if ($tipo === 'empregado') {
            $model = new EmpregadoModel();
            $usuario = $model->where('email', $email)->first();
        } else {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Tipo inválido. Use empregado ou cliente.'
            ])->setStatusCode(400);
        }

        if ($usuario && password_verify($senha, $usuario['senha'])) {
            $payload = [
                'iss' => 'certeira_api',
                'sub' => $usuario['codigo'],
                'email' => $usuario['email'],
                'tipo' => $tipo,
                'iat' => time(),
                'exp' => time() + 3600
            ];

            $jwt = JWT::encode($payload, getenv('JWT_SECRET'), 'HS256');

            return $this->response->setJSON([
                'status' => true,
                'mensagem' => 'Login realizado com sucesso.',
                'token' => $jwt,
                'usuario' => $usuario
            ]);
        } else {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Email ou senha inválidos.'
            ])->setStatusCode(401);
        }
    }
}
