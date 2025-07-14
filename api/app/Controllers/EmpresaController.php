<?php

namespace App\Controllers;

use App\Models\EmpresaModel;
use App\Controllers\EnderecoController;
use CodeIgniter\RESTful\ResourceController;

class EmpresaController extends ResourceController {
    protected $empresaModel;
    protected $enderecoController;
    
    public function __construct(){
    $this->empresaModel = new EmpresaModel();
    $this->enderecoController = new EnderecoController();
    }

    public function toArray($codigo = null) {
        $empresa = $this->empresaModel->find($codigo);

        if (!$empresa) {
            return null;
        }

        $endereco = $this->enderecoController->toArray($empresa['codigoEndereco']);

        return [
            'codigo' => $empresa['codigo'],
            'razao' => $empresa['razao'],
            'fantasia' => $empresa['fantasia'],
            'cnpj' => $empresa['cnpj'],
            'im' => $empresa['im'],
            'codigoEndereco' => $empresa['codigoEndereco'],
            'dataCadastro' => $empresa['dataCadastro'],
            'dataDesativado' => $empresa['dataDesativado'],
            'endereco' => $endereco,
        ];
    }

    public function index() {
        $empresas = $this->empresaModel->findAll();

        $resultado = [];

        foreach ($empresas as $empresa) {
            $endereco = $this->enderecoController->toArray($empresa['codigoEndereco']);

            $resultado[] = [
                'codigo' => $empresa['codigo'],
                'razao' => $empresa['razao'],
                'fantasia' => $empresa['fantasia'],
                'cnpj' => $empresa['cnpj'],
                'im' => $empresa['im'],
                'codigoEndereco' => $empresa['codigoEndereco'],
                'dataCadastro' => $empresa['dataCadastro'],
                'dataDesativado' => $empresa['dataDesativado'],
                'endereco' => $endereco,
            ];
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null) {
        return $this->response->setJSON($this->toArray($codigo));
    }

    public function create() {
        $dados = $this->request->getJSON(true);

        if(empty($dados['razao'])||empty($dados['fantasia'])||empty($dados['cnpj'])||empty($dados['im'])){
            return $this->failValidationErrors("Campos 'Razão', 'Fantasia', 'CNPJ' ou 'IM' obrigatórios");
        }

        $empresaData = [
            'razao' => trim($dados['razao']),
            'fantasia' => trim($dados['fantasia']),
            'cnpj' => trim($dados['cnpj']),
            'im' => trim($dados['im']),
            'codigoEndereco' => $dados['codigoEndereco'],
            'dataCadastro' => date('Y-m-d H:i:s'),
            'dataDesativado' => null,
        ];

        $this->empresaModel->insert($empresaData);

        return $this->response->setJSON($this->toArray($this->empresaModel->getInsertID()));
    }

    public function update($codigo = null) {
        $dados = $this->request->getJSON(true);

        if($this->toArray($codigo) === null || empty(trim($dados['razao'])) || empty(trim($dados['fantasia']))){
            return $this->failNotFound('Empresa não encontrada!');
        }

        $empresaData = [
            'razao' => trim($dados['razao']),
            'fantasia' => trim($dados['fantasia']),
            'cnpj' => trim($dados['cnpj']),
            'im' => trim($dados['im']),
            'codigoEndereco' => $dados['codigoEndereco'],
            'dataCadastro' => trim($dados['dataCadastro']),
            'dataDesativado' => trim($dados['dataDesativado']),
        ];

        $this->empresaModel->update($codigo, $empresaData);

        return $this->response->setJSON($this->toArray($this->empresaModel->getInsertID()));
    }

    public function delete($codigo = null) {
        if($this->toArray($codigo) === null){
            return $this->failNotFound('Empresa não encontrada');
        }

        $empresaData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        $this->empresaModel->update($codigo, $empresaData);

        return $this->respondCreated(['message' => 'Empresa desativada com sucesso']);
    }
}











