<?php

namespace App\Controllers;

use App\Models\CidadeModel;
use App\Controllers\EstadoController;
use CodeIgniter\RESTful\ResourceController;

class CidadeController extends ResourceController {
    protected $cidadeModel;
    protected $estadoController;

    public function __construct() {
        $this->cidadeModel = new CidadeModel();
        $this->estadoController = new EstadoController();
    }

    public function toArray($codigo = null) {
        $cidade = $this->cidadeModel->find($codigo);

        if (!$cidade) {
            return null;
        }

        $estado = $this->estadoController->toArray($cidade['codigoEstado']);

        return [
            'codigo' => $cidade['codigo'],
            'cidade' => $cidade['cidade'],
            'codigoEstado' => $cidade['codigoEstado'],
            'dataCadastro' => $cidade['dataCadastro'],
            'estado' => $estado,
        ];
    }

    public function index() {
        $cidades = $this->cidadeModel->findAll();

        $resultado = [];

        foreach ($cidades as $cidade) {
            $estadoData = $this->estadoController->toArray($cidade['codigoEstado']);
            $resultado[] =  [
                'codigo' => $cidade['codigo'],
                'cidade' => $cidade['cidade'],
                'codigoEstado' => $cidade['codigoEstado'],
                'dataCadastro' => $cidade['dataCadastro'],
                'estado' => $estadoData,
            ];
        }
        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null) {
        return $this->response->setJSON($this->toArray($codigo));
    }

    public function create() {
        $dados = $this->request->getJSON(true);

        if (empty(trim($dados['cidade'])) || empty(trim($dados['ibge']))) {
            return $this->failValidationErrors("Campo 'Cidade' e 'IBGE' obrigatórios!");
        }

        $cidadeData = [
            'cidade' => trim($dados['cidade']),
            'codigoEstado' => $dados['codigoEstado'],
            'ibge' => trim($dados['ibge']),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        $this->cidadeModel->insert($cidadeData);

        return $this->response->setJSON($this->toArray($this->cidadeModel->getInsertID()));
    }

    public function update($codigo = null) {
        $dados = $this->request->getJSON(true);

        if($this->toArray($codigo === null || empty(trim($dados['cidade'])))){
            return $this->failNotFound('Cidade não encontrada!');
        }

        $cidadeData = [
            'cidade' => trim($dados['cidade']),
            'ibge' => trim($dados['ibge']),
            'codigoEstado' => trim($dados['codigoEstado']),
        ];

        $this->cidadeModel->update($codigo, $cidadeData);

        return $this->response->setJSON($this->toArray($this->cidadeModel->getInsertID()));
    }

    public function delete($codigo = null) {
        if($this->toArray($codigo === null)){
            return $this->failNotFound('Cidade não encontrada!');
        }

        $cidadeData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->cidadeModel->update($codigo, $cidadeData);

        return $this->respond(['message' => 'Cidade desativada com sucesso.']);
    }
}











