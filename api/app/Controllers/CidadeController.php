<?php

namespace App\Controllers;

use App\Models\CidadeModel;
use App\Models\EstadoModel;
use CodeIgniter\RESTful\ResourceController;

class Cidade extends ResourceController
{
    protected $cidadeModel;
    protected $estadoModel;

    public function __construct()
    {
        $this->cidadeModel = new CidadeModel();
        $this->estadoModel = new EstadoModel();
    }

    public function toArray($codigo = null)
    {
        if (!$codigo) {
            return null;
        }

        $cidade = $this->cidadeModel->find($codigo);

        if (!$cidade) {
            return null;
        }

        $estado = $this->estadoModel->toArray($cidade['codigoEstado']);

        return [
            'codigo' => $cidade['codigo'] ?? null,
            'cidade' => $cidade['cidade'] ?? null,
            'dataCadastro' => $cidade['dataCadastroCidade'] ?? null,
            'estado' => $estado,
        ];
    }

    public function index()
    {
        $cidades = $this->cidadeModel->findAll();
        $resultado = [];

        foreach ($cidades as $cidade) {
            $estado = null;

            if (!empty($cidade['codigoEstado'])) {
                $estado = $this->estadoModel->find($cidade['codigoEstado']);
            }

            $cidadeData = [
                'codigo' => $cidade['codigo'] ?? null,
                'cidade' => $cidade['cidade'] ?? null,
                'dataCadastro' => $cidade['dataCadastroCidade'] ?? null,
                'estado' => $estado ? [
                    'codigo' => $estado['codigo'] ?? null,
                    'estado' => $estado['estado'] ?? null,
                    'uf' => $estado['uf'] ?? null,
                    'dataCadastro' => $estado['dataCadastro'] ?? null,
                ] : null,
            ];

            $resultado[] = $cidadeData;
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null)
    {
        $cidade = $this->cidadeModel->find($codigo);

        if (!$cidade) {
            return $this->failNotFound('Cidade não encontrada!');
        }

        $estado = null;
        if (!empty($cidade['codigoEstado'])) {
            $estado = $this->estadoModel->find($cidade['codigoEstado']);
        }

        $cidadeData = [
            'codigo' => $cidade['codigo'] ?? null,
            'cidade' => $cidade['cidade'] ?? null,
            'dataCadastro' => $cidade['dataCadastroCidade'] ?? null,
            'estado' => $estado ? [
                'codigo' => $estado['codigo'] ?? null,
                'estado' => $estado['estado'] ?? null,
                'uf' => $estado['uf'] ?? null,
                'dataCadastro' => $estado['dataCadastro'] ?? null,
            ] : null,
        ];

        return $this->response->setJSON($cidadeData);
    }

    public function create()
    {
        $dados = $this->request->getJSON(true);

        if (empty($dados['cidade'])) {
            return $this->failValidationErrors("Campo 'cidade' obrigatório!");
        }

        if (empty($dados['codigoEstado'])) {
            return $this->failValidationErrors("Campo 'codigoEstado' obrigatório!");
        }

        $cidadeData = [
            'cidade' => trim($dados['cidade']),
            'codigoEstado' => $dados['codigoEstado'],
            'dataCadastroCidade' => date('Y-m-d H:i:s'),
        ];

        $this->cidadeModel->insert($cidadeData);

        return $this->respondCreated(['message' => 'Cidade criada com sucesso.']);
    }

    // PUT /cidade/{id}
    public function update($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        $cidade = $this->cidadeModel->find($codigo);

        if (!$cidade) {
            return $this->failNotFound('Cidade não encontrada!');
        }

        $cidadeData = [
            'cidade' => trim($dados['cidade'] ?? $cidade['cidade']),
            'codigoEstado' => $dados['codigoEstado'] ?? $cidade['codigoEstado'],
        ];

        $this->cidadeModel->update($codigo, $cidadeData);

        return $this->respond(['message' => 'Cidade atualizada com sucesso.']);
    }

    // DELETE /cidade/{id}
    public function delete($codigo = null)
    {
        $cidade = $this->cidadeModel->find($codigo);

        if (!$cidade) {
            return $this->failNotFound('Cidade não encontrada!');
        }

        $cidadeData = [
            'dataDesativadoCidade' => date('Y-m-d H:i:s'),
        ];

        $this->cidadeModel->update($codigo, $cidadeData);

        return $this->respond(['message' => 'Cidade desativada com sucesso.']);
    }
}
