<?php

namespace App\Controllers;

use App\Models\BairroModel;
use CodeIgniter\RESTful\ResourceController;

class BairroController extends ResourceController
{
    protected $bairroModel;

    public function __construct()
    {
        $this->bairroModel = new BairroModel();
    }

    public function toArray($codigo = null)
    {
        $bairro = $this->bairroModel->find($codigo);

        if (!$bairro) {
            return null;        
        }

        return [
            'codigo' => $bairro['codigo'],
            'bairro' => $bairro['bairro'],
            'dataCadastro' => $bairro['dataCadastro'],
        ];
    }

    public function index()
    {
        $bairros = $this->bairroModel->findAll();

        $resultado = [];

        foreach ($bairros as $bairro) {
            $bairroData = null;
            $bairroData = $this->toArray($bairro['codigo']);

            $resultado[] = $bairroData;
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null)
    {
        $bairroData = $this->toArray($codigo);

        return $this->response->setJSON($bairroData);
    }

    public function create()
    {
        $dados = $this->request->getJSON(true);

        if(empty(trim($dados['bairro']))){
            return $this->failValidationErrors("Campo 'Bairro' obrigatório!");
        }

        $bairroData = [
            'bairro' => $dados['bairro'],
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];
        $this->bairroModel->insert($bairroData);

        return $this->respondCreated(['message' => 'Bairro criado com sucesso.']);
    }

    public function update($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        if ($this->toArray($codigo) === null || empty(trim($dados['bairro']))) {
            return $this->failNotFound('Bairro não encontrado!');
        }

        $bairroData = [
            'bairro' => trim($dados['bairro']),
        ];

        $this->bairroModel->update($codigo, $bairroData);

        return $this->respond(['message' => 'Bairro atualizada com sucesso.']);
    }

    public function delete($codigo = null)
    {
        if ($this->toArray($codigo) === null) {
            return $this->failNotFound('Bairro não encontrado!');
        }

        $bairroData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->bairroModel->update($codigo, $bairroData);

        return $this->respond(['message' => 'Bairro desativada com sucesso.']);
    }
}
