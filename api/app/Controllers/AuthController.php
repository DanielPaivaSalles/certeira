<?php

namespace App\Controllers;

use App\Models\EmpregadoModel;
use App\Models\ClienteModel;
use CodeIgniter\RESTful\ResourceController;
use Firebase\JWT\JWT;

class AuthController extends ResourceController {
    //Metodo de login de usuário
    public function login() {
        //Pega os dados do post feito
        $json = $this->request->getJSON(true);

        //Parametros necessários para validar dados
        $tipo = $json['tipo'] ?? '';
        $email = $json['email'] ?? '';
        $senha = $json['senha'] ?? '';

        // Usar dados do .env apenas em desenvolvimento
        if (ENVIRONMENT === 'development' && (!$tipo || !$email || !$senha)) {
            $tipo = getenv('TEST_USER_TYPE');
            $email = getenv('TEST_USER_EMAIL');
            $senha = getenv('TEST_USER_PASSWORD');
        }

        //Se algum parametro estiver vazio, devolve erro 400
        if (!$tipo || !$email || !$senha) {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Tipo, email ou senha são obrigatórios.'
            ])->setStatusCode(400);
        }

        //A condicional verifica se o login é de empregado. Caso seja, ele busca por um empregado com 
        //email igual ao digitado cadastrado. Se não, retorna erro 400.
        if ($tipo === 'empregado') {
            $empregadoModel = new EmpregadoModel();
            $usuario = $empregadoModel->where('email', $email)->first();
        } else {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Tipo inválido. Use empregado ou cliente.'
            ])->setStatusCode(400);
        }

        //Se empregado for encontrado, se compara a senha digitada com o hash na base de dados. Caso
        //seja igual, é criado um token de acesso.
        //Se não, vai retornar erro 401.
        if ($usuario && password_verify($senha, $usuario['senha'])) {
            $payload = [
                'iss' => 'certeira_api',
                'sub' => $usuario['codigo'],
                'email' => $usuario['email'],
                'tipo' => $tipo,
                'iat' => time(),
                'exp' => time() + 3600
            ];

            //Em seguida o token é criptografado
            $jwtSecret = getenv('JWT_SECRET');
            if (!$jwtSecret) {
                return $this->response->setJSON([
                    'status' => false,
                    'mensagem' => 'Configuração de segurança inválida.'
                ])->setStatusCode(500);
            }
            $jwt = JWT::encode($payload, $jwtSecret, 'HS256');

            //Depois de pronto, o token é entregue via json.
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
