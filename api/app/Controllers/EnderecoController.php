<?php

namespace App\Controllers;

use App\Models\EnderecoModel;
use App\Controllers\RuaController;
use App\Controllers\BairroController;
use App\Controllers\CidadeController;
use CodeIgniter\RESTful\ResourceController;

class Endereco extends ResourceController
{
    protected $enderecoModel;
    protected $ruaController;
    protected $bairroController;
    protected $cidadeController;

    public function __construct() {
        $this->enderecoModel = new EnderecoModel();
        $this->ruaController = new RuaController();
        $this->bairroController = new BairroController();
        $this->cidadeController = new CidadeController();
    }

    public function toArray($codigo = null) {
        $endereco = $this->enderecoModel->find($codigo);

        if (!$endereco) {
            return null;
        }

        $rua = $this->ruaController->toArray($endereco['codigoRua']);
        $bairro = $this->bairroController->toArray($endereco['codigoBairro']);
        $cidade = $this->cidadeController->toArray($endereco['codigoCidade']);

        return [
            'codigo' => $endereco['codigo'] ?? null,
            'codigoRua' => $endereco['codigoRua'] ?? null,
            'numero' => $endereco['numero'] ?? null,
            'codigoBairro' => $endereco['codigoBairro'] ?? null,
            'codigoCidade' => $endereco['codigoCidade'] ?? null,
            'cep' => $endereco['cep'] ?? null,
            'dataCadastro' => $endereco['dataCadastro'] ?? null,
            'rua' => $rua,
            'bairro' => $bairro,
            'cidade' => $cidade,
        ];
    }

    public function index() {
        $enderecos = $this->enderecoModel->findAll();

        $resultado = [];

        foreach ($enderecos as $endereco) {
            $rua = $this->ruaController->toArray($endereco['codigoRua']);
            $bairro = $this->bairroController->toArray($endereco['codigoBairro']);
            $cidade = $this->cidadeController->toArray($endereco['codigoCidade']);

            $resultado[] = [
                'codigo' => $endereco['codigo'],
                'codigoRua' => $endereco['codigoRua'],
                'numero' => $endereco['numero'],
                'codigoBairro' => $endereco['codigoBairro'],
                'codigoCidade' => $endereco['codigoCidade'],
                'cep' => $endereco['cep'],
                'dataCadastroEndereco' => $endereco['dataCadastroEndereco'],
                'dataDesativadoEndereco' => $endereco['dataDesativadoEndereco'],
                'rua' => $rua,
                'bairro' => $bairro,
                'cidade' => $cidade,
            ];
        }

        return $this->response->setJSON($resultado);
    }

    public function show($codigo = null) {
        $enderecoData = $this->toArray($codigo);

        return $this->response->setJSON($enderecoData);
    }

    public function create() {
        $dados = $this->request->getJSON(true);

        if(empty(trim($dados['numero'])) || empty(trim($dados['cep']))) {
            return $this->failValidationErrors("Campo 'Número' e 'CEP' obrigatórios!");
        }

        $enderecoData = [
            'codigoRua' => $dados['codigoRua'],
            'numero' => trim($dados['numero']),
            'codigoBairro' => $dados['codigoBairro'],
            'codigoCidade' => $dados['codigoCidade'],
            'cep' => trim($dados['cep']),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        $this->enderecoModel->insert($enderecoData);

        return $this->respondCreated(['message' => 'Endereço criado com sucesso.']);
    }

    public function update($codigo = null) {
        $dados = $this->request->getJSON(true);

        if($this->toArray($codigo) === null) {
            return $this->failNotFound('Endereço não encontrado!');
        }

        $enderecoData = [
            'codigoRua' => trim($dados['codigoRua']),
            'numero' => trim($dados['numero']),
            'codigoBairro' => trim($dados['codigoBairro']),
            'codigoCidade' => trim($dados['codigoCidade']),
            'cep' => trim($dados['cep']),
        ];


        $this->enderecoModel->update($codigo, $enderecoData);

        return $this->respond(['message' => 'Endereço atualizado com sucesso.']);
    }

    public function delete($codigo = null) {
        if($this->toArray($codigo) === null) {
            return $this->failNotFound('Endereço não encontrada!');
        }

        $enderecoData = [
            'dataDesativadoCidade' => date('Y-m-d H:i:s'),
        ];

        $this->enderecoModel->update($codigo, $enderecoData);

        return $this->respond(['message' => 'Endereço desativado com sucesso.']);
    }
}
