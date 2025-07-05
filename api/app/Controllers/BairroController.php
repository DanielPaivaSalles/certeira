<?php

namespace App\Controllers;

use App\Models\BairroModel;
use CodeIgniter\RESTful\ResourceController;

class Bairro extends ResourceController
{
    protected $bairroModel;

    public function __construct()
    {
        $this->bairroModel = new BairroModel();
    }

    public function toArray($codigo = null)
    {
        if (!$codigo) {
            return null;
        }

        $bairro = $this->bairroModel->find($codigo);

        if (!$bairro) {
            return null;
        }

        return [
            'codigo' => $bairro['codigo'] ?? null,
            'bairro' => $bairro['bairro'] ?? null,
            'dataCadastro' => $bairro['dataCadastro'] ?? null,
        ];
    }

    public function index()
    {
        $bairros = $this->bairroModel->findAll();

        $resultado = [];

        foreach ($bairros as $bairro) {
            $bairroData = [
                'codigo' => $bairro['codigo'] ?? null,
                'bairro' => $bairro['bairro'] ?? null,
                'dataCadastro' => $bairro['dataCadastro'] ?? null,
            ];

            $resultado[] = $bairroData;
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null)
    {
        $bairro = $this->bairroModel->find($codigo);

        if (!$bairro) {
            return $this->failNotFound('Bairro não encontrada!');
        }

        $bairroData = [
            'codigo' => $bairro['codigo']??null,
            'bairro' => $bairro['bairro']??null,
            'dataCadastro' => $bairro['dataCadastro']??null,
        ];

        return $this->response->setJSON($bairroData);
    }

    public function create()
    {
        $dados = $this->request->getJSON(true);

        if(empty($dados['bairro'])){
            return $this->failValidationErrors("Campo 'Bairro' obrigatório!");
        }

        $bairroData = [
            'bairro' => trim($dados['bairro'] ?? ''),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];
        $this->bairroModel->insert($bairroData);

        return $this->respondCreated(['message' => 'Bairro criada com sucesso.']);
    }

    public function update($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        $bairro = $this->bairroModel->find($codigo);

        if (!$bairro) {
            return $this->failNotFound('Bairro não encontrada!');
        }

        $bairroData = [
            'bairro' => trim($dados['bairro'] ?? ''),
        ];

        $this->bairroModel->update($codigo, $bairroData);

        return $this->respond(['message' => 'Bairro atualizada com sucesso.']);
    }

    public function delete($codigo = null)
    {
        $bairro = $this->bairroModel->find($codigo);

        if (!$bairro) {
            return $this->failNotFound('Bairro não encontrada!');
        }

        $bairroData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->bairroModel->update($codigo, $bairroData);

        return $this->respond(['message' => 'Bairro desativada com sucesso.']);
    }
}
