<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        $authHeader = $request->getHeaderLine('Authorization');
        
        if (!$authHeader) {
            return service('response')->setJSON([
                'status' => false,
                'mensagem' => 'Token de autorização necessário.'
            ])->setStatusCode(401);
        }

        $token = str_replace('Bearer ', '', $authHeader);
        
        try {
            $jwtSecret = getenv('JWT_SECRET');
            $decoded = JWT::decode($token, new Key($jwtSecret, 'HS256'));
            
            // Adiciona dados do usuário à requisição
            $request->user = $decoded;
            return $request;
            
        } catch (\Exception $e) {
            // Log de tentativa de acesso não autorizado
            log_message('security', 'Tentativa de acesso com token inválido: ' . $request->getIPAddress() . ' - ' . $e->getMessage());

            return service('response')->setJSON([
                'status' => false,
                'mensagem' => 'Token inválido: ' . $e->getMessage()
            ])->setStatusCode(401);
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // Não precisa de implementação
    }
}
