<?php

namespace App\Controllers;

use App\Models\EstadoModel;
use CodeIgniter\RESTful\ResourceController;

class Estado extends ResourceController
{
    protected $estadoModel;

    public function __construct()
    {
        $this->estadoModel = new EstadoModel();
    }

    public function toArray($codigo = null)
    {
        if (!$codigo) {
            return null;
        }

        $estado = $this->estadoModel->find($codigo);

        if (!$estado) {
            return null;
        }

        return [
            'codigo' => $estado['codigo'] ?? null,
            'estado' => $estado['estado'] ?? null,
            'uf' => $estado['uf'] ?? null,
            'dataCadastro' => $estado['dataCadastro'] ?? null,
        ];
    }

    public function gets()
    {
        $estados = $this->estadoModel->findAll();

        $resultado = [];

        foreach ($estados as $estado) {
            $estadoData = null;

            $estadoData = [
                'codigo' => $estado['codigo'] ?? null,
                'estado' => $estado['estado'] ?? null,
                'uf' => $estado['uf'] ?? null,
                'dataCadastro' => $estado['dataCadastro'] ?? null,
            ];

            $resultado[] = $estadoData;
        }

        return $this->response->setJSON($resultado);
    }

    public function get($codigo = null)
    {
        $estado = $this->estadoModel->find($codigo);

        if (!$estado) {
            return $this->failNotFound('Estado não encontrada!');
        }

        $estadoData = [
            'codigo' => $estado['codigo']??null,
            'estado' => $estado['estado']??'',
            'uf' => $estado['uf'] ?? '',
            'dataCadastro' => $estado['dataCadastro']??null,
        ];

        return $this->response->setJSON($estadoData);
    }

    public function post()
    {
        $dados = $this->request->getJSON(true);

        if(empty($dados['estado'])){
            return $this->failValidationErrors("Campo 'Estado' obrigatório!");
        }

        $estadoData = [
            'estado' => trim($dados['estado'] ?? ''),
            'uf' => $dados['uf'] ?? '',
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];
        $this->estadoModel->insert($estadoData);

        return $this->respondCreated(['message' => 'Estado criada com sucesso.']);
    }

    public function put($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        $estado = $this->estadoModel->find($codigo);

        if (!$estado) {
            return $this->failNotFound('Estado não encontrada!');
        }

        $estadoData = [
            'estado' => trim($dados['estado'] ?? ''),
            'uf' => $dados['uf'] ?? '',
        ];

        $this->estadoModel->update($codigo, $estadoData);

        return $this->respond(['message' => 'Estado atualizada com sucesso.']);
    }

    public function delete($codigo = null)
    {
        $estado = $this->estadoModel->find($codigo);

        if (!$estado) {
            return $this->failNotFound('Estado não encontrada!');
        }

        $estadoData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->estadoModel->update($codigo, $estadoData);

        return $this->respond(['message' => 'Estado desativada com sucesso.']);
    }
}
