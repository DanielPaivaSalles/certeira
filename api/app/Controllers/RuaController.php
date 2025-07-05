<?php

namespace App\Controllers;

use App\Models\RuaModel;
use CodeIgniter\RESTful\ResourceController;

class Rua extends ResourceController
{
    protected $ruaModel;

    public function __construct()
    {
        $this->ruaModel = new RuaModel();
    }

    public function toArray($codigo = null)
    {
        if (!$codigo) {
            return null;
        }

        $rua = $this->ruaModel->find($codigo);

        if (!$rua) {
            return null;
        }

        return [
            'codigo' => $rua['codigo'] ?? null,
            'rua' => $rua['rua'] ?? null,
            'dataCadastro' => $rua['dataCadastro'] ?? null,
        ];
    }

    public function gets()
    {
        $ruas = $this->ruaModel->findAll();

        $resultado = [];

        foreach ($ruas as $rua) {
            $ruaData = [
                'codigo' => $rua['codigo'] ?? null,
                'rua' => $rua['rua'] ?? null,
                'dataCadastro' => $rua['dataCadastro'] ?? null,
            ];

            $resultado[] = $ruaData;
        }

        return $this->response->setJSON($resultado);
    }

    public function get($codigo = null)
    {
        $rua = $this->ruaModel->find($codigo);

        if (!$rua) {
            return $this->failNotFound('Rua não encontrada!');
        }

        $ruaData = [
            'codigo' => $rua['codigo']??null,
            'rua' => $rua['rua']??null,
            'dataCadastro' => $rua['dataCadastro']??null,
        ];

        return $this->response->setJSON($ruaData);
    }

    public function post()
    {
        $dados = $this->request->getJSON(true);

        if(empty($dados['rua'])){
            return $this->failValidationErrors("Campo 'Rua' obrigatório!");
        }

        $ruaData = [
            'rua' => trim($dados['rua'] ?? ''),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];
        $this->ruaModel->insert($ruaData);

        return $this->respondCreated(['message' => 'Rua criada com sucesso.']);
    }

    public function put($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        $rua = $this->ruaModel->find($codigo);

        if (!$rua) {
            return $this->failNotFound('Rua não encontrada!');
        }

        $ruaData = [
            'rua' => trim($dados['rua'] ?? ''),
        ];

        $this->ruaModel->update($codigo, $ruaData);

        return $this->respond(['message' => 'Rua atualizada com sucesso.']);
    }

    public function delete($codigo = null)
    {
        $rua = $this->ruaModel->find($codigo);

        if (!$rua) {
            return $this->failNotFound('Rua não encontrada!');
        }

        $ruaData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->ruaModel->update($codigo, $ruaData);

        return $this->respond(['message' => 'Rua desativada com sucesso.']);
    }
}
