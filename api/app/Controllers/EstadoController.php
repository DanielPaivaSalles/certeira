<?php

namespace App\Controllers;

use App\Models\EstadoModel;
use CodeIgniter\RESTful\ResourceController;

class EstadoController extends ResourceController {
    protected $estadoModel;

    public function __construct() {
        $this->estadoModel = new EstadoModel();
    }

    public function toArray($codigo = null) {
        $estado = $this->estadoModel->find($codigo);

        if (!$estado) {
            return null;
        }

        return [
            'codigo' => $estado['codigo'],
            'estado' => $estado['estado'],
            'uf' => $estado['uf'],
            'dataCadastro' => $estado['dataCadastro'],
        ];
    }

    public function index() {
        $estados = $this->estadoModel->findAll();

        $resultado = [];

        foreach ($estados as $estado) {
            $estadoData = null;
            $estadoData = $this->toArray($estado['codigo']);

            $resultado[] = $estadoData;
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null) {
        $estadoData = $this->toArray($codigo);

        return $this->response->setJSON($estadoData);

    }

    public function create() {
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

    public function update($codigo = null) {
        $dados = $this->request->getJSON(true);

        if ($this->toArray($codigo) === null || empty(trim($dados['estado']))) {
            return $this->failNotFound('Estado não encontrado!');
        }

        $estadoData = [
            'estado' => trim($dados['estado']),
            'uf' => $dados['uf'],
        ];

        $this->estadoModel->update($codigo, $estadoData);

        return $this->respond(['message' => 'Estado atualizada com sucesso.']);
    }

    public function delete($codigo = null) {
        if ($this->toArray($codigo) === null) {
            return $this->failNotFound('Estado não encontrado!');
        }

        $estadoData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->estadoModel->update($codigo, $estadoData);

        return $this->respond(['message' => 'Estado desativada com sucesso.']);
    }
}
