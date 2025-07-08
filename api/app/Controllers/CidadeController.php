<?php

namespace App\Controllers;

use App\Models\CidadeModel;
use App\Controllers\EstadoController;
use CodeIgniter\RESTful\ResourceController;

class CidadeController extends ResourceController
{
    protected $cidadeModel;
    protected $estadoController;

    public function __construct()
    {
        $this->cidadeModel = new CidadeModel();
        $this->estadoController = new EstadoController();
    }

    public function toArray($codigo = null)
    {
        $cidade = $this->cidadeModel->find($codigo);

        if (!$cidade) {
            return null;
        }

        $estado = $this->estadoController->toArray($cidade['codigoEstado']);

        return [
            'codigo' => $cidade['codigo'],
            'cidade' => $cidade['cidade'],
            'codigoEstado' => $cidade['codigoEstado'],
            'dataCadastro' => $cidade['dataCadastroCidade'],
            'estado' => $estado,
        ];
    }

    public function index()
    {
        $cidades = $this->cidadeModel->findAll();
        $resultado = [];

        foreach ($cidades as $cidade) {
            $cidadeData = null;
            $estadoData = null;

            $estadoData = $this->estadoController->toArray($cidade['codigoEstado']);
            $cidadeData = [
                'codigo' => $cidade['codigo'],
                'cidade' => $cidade['cidade'],
                'codigoEstado' => $cidade['codigoEstado'],
                'dataCadastro' => $cidade['dataCadastroCidade'],
                'estado' => $estadoData,
            ];

            $resultado[] = $cidadeData;
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null)
    {
        $cidadeData = $this->toArray($codigo);

        return $this->response->setJSON($cidadeData);
    }

    public function create()
    {
        $dados = $this->request->getJSON(true);

        if (empty(trim($dados['cidade'])) || empty(trim($dados['ibge']))) {
            return $this->failValidationErrors("Campo 'Cidade' obrigatório!");
        }

        $cidadeData = [
            'cidade' => trim($dados['cidade']),
            'codigoEstado' => $dados['codigoEstado'],
            'ibge' => $dados['ibge'],
            'dataCadastroCidade' => date('Y-m-d H:i:s'),
        ];

        $this->cidadeModel->insert($cidadeData);

        return $this->respondCreated(['message' => 'Cidade criada com sucesso.']);
    }

    public function update($codigo = null)
    {
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

        return $this->respond(['message' => 'Cidade atualizada com sucesso.']);
    }

    public function delete($codigo = null)
    {
        if($this->toArray($codigo === null)){
            return $this->failNotFound('Cidade não encontrada!');
        }

        $cidadeData = [
            'dataDesativadoCidade' => date('Y-m-d H:i:s'),
        ];

        $this->cidadeModel->update($codigo, $cidadeData);

        return $this->respond(['message' => 'Cidade desativada com sucesso.']);
    }
}
