<?php

namespace App\Controllers;

use App\Models\EmpregadoModel;
use CodeIgniter\RESTful\ResourceController;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Empregado extends ResourceController
{
    public function index()
    {
        $model = new EmpregadoModel();
        $data = $model->findAll();

        return $this->response->setJSON($data);
    }

    public function login()
    {
        $json = $this->request->getJSON(true);
        $email = $json['email'] ?? '';
        $senha = $json['senha'] ?? '';

        if (!$email || !$senha) {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Email ou senha são obrigatórios.'
            ])->setStatusCode(400);
        }

        $model = new EmpregadoModel();
        $empregado = $model->where('email', $email)->first();

        if ($empregado && password_verify($senha, $empregado['senha'])) {
            $payload = [
                'iss' => 'certeira_api',
                'sub' => $empregado['codigo'],
                'email' => $empregado['email'],
                'iat' => time(),
                'exp' => time()+3600
            ];

            $jwt = JWT::encode($payload, getenv('JWT_SECRET'), 'HS256');

            return $this->response->setJSON([
                'status' => true,
                'mensagem' => 'Login realizado com sucesso.',
                'token' => $jwt,
                'empregado' => $empregado
            ]);
        } else {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Email ou senha inválidos.'
            ])->setStatusCode(401);
        }
    }

}

