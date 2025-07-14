<?php

namespace App\Controllers;

use App\Models\RuaModel;
use CodeIgniter\RESTful\ResourceController;

class RuaController extends ResourceController {
    protected $ruaModel;

    public function __construct() {
        $this->ruaModel = new RuaModel();
    }

    public function toArray($codigo = null) {
        $rua = $this->ruaModel->find($codigo);

        if (!$rua) {
            return null;
        }

        return [
            'codigo' => $rua['codigo'],
            'rua' => $rua['rua'],
            'dataCadastro' => $rua['dataCadastro'],
        ];
    }

    public function index() {
        $ruas = $this->ruaModel->findAll();

        $resultado = [];

        foreach ($ruas as $rua) {
            $ruaData = $this->toArray($rua['codigo']);

            $resultado[] = $ruaData;
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null) {
        return $this->response->setJSON($this->toArray($codigo));
    }

    public function create() {
        $dados = $this->request->getJSON(true);

        if(empty($dados['rua'])){
            return $this->failValidationErrors("Campo 'Rua' obrigatório!");
        }

        $ruaData = [
            'rua' => trim($dados['rua']),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];
        $this->ruaModel->insert($ruaData);

        return $this->response->setJSON($this->toArray($this->ruaModel->getInsertID()));
    }

    public function update($codigo = null) {
        $dados = $this->request->getJSON(true);

        if ($this->toArray($codigo) === null || empty(trim($dados['rua']))) {
            return $this->failNotFound('Rua não encontrada!');
        }

        $ruaData = [
            'rua' => trim($dados['rua']),
        ];

        $this->ruaModel->update($codigo, $ruaData);

        return $this->response->setJSON($this->toArray($this->ruaModel->getInsertID()));
    }

    public function delete($codigo = null) {
        if ($this->toArray($codigo) === null) {
            return $this->failNotFound('Rua não encontrada!');
        }

        $ruaData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->ruaModel->update($codigo, $ruaData);

        return $this->respond(['message' => 'Rua desativada com sucesso.']);
    }
}











