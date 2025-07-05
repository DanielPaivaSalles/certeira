<?php

namespace App\Controllers;

use App\Models\EnderecoModel;
use App\Models\RuaModel;
use App\Models\BairroModel;
use App\Models\CidadeModel;
use CodeIgniter\RESTful\ResourceController;

class Endereco extends ResourceController
{
    protected $enderecoModel;
    protected $ruaModel;
    protected $bairroModel;
    protected $cidadeModel;

    public function __construct()
    {
        $this->enderecoModel = new EnderecoModel();
        $this->ruaModel = new RuaModel();
        $this->bairroModel = new BairroModel();
        $this->cidadeModel = new CidadeModel();
    }

    public function toArray($codigo = null)
    {
        if (!$codigo) {
            return null;
        }

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

    public function index()
    {
        $enderecos = $this->enderecoModel->findAll();

        $resultado = [];

        foreach ($enderecos as $endereco) {
            $rua = $this->ruaModel->find($endereco['codigoRua']);
            $bairro = $this->bairroModel->find($endereco['codigoBairro']);
            $cidade = $this->cidadeModel->find($endereco['codigoCidade']);

            $resultado[] = [
                'codigo' => $endereco['codigo'],
                'codigoRua' => $endereco['codigoRua'] ?? null,
                'numero' => $endereco['numero'],
                'codigoBairro' => $endereco['codigoBairro'] ?? null,
                'codigoCidade' => $endereco['codigoCidade'] ?? null,
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

    public function show($codigo = null)
    {
        $endereco = $this->enderecoModel->find($codigo);

        if (!$endereco) {
            return $this->failNotFound('Endereço não encontrado.');
        }

            $rua = $this->ruaModel->find($endereco['codigoRua']);
            $bairro = $this->bairroModel->find($endereco['codigoBairro']);
            $cidade = $this->cidadeModel->find($endereco['codigoCidade']);

            $enderecoCompleto[] = [
                'codigo' => $endereco['codigo'],
                'codigoRua' => $endereco['codigoRua'] ?? null,
                'numero' => $endereco['numero'],
                'codigoBairro' => $endereco['codigoBairro'] ?? null,
                'codigoCidade' => $endereco['codigoCidade'] ?? null,
                'cep' => $endereco['cep'],
                'dataCadastroEndereco' => $endereco['dataCadastroEndereco'],
                'dataDesativadoEndereco' => $endereco['dataDesativadoEndereco'],
                'rua' => $rua,
                'bairro' => $bairro,
                'cidade' => $cidade,
            ];

        return $this->response->setJSON($enderecoCompleto);
    }

    public function create()
    {
        $dados = $this->request->getJSON(true);

        $this->enderecoModel->insert($dados);

        return $this->respondCreated(['message' => 'Endereço criado com sucesso.']);
    }

    public function update($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        $this->enderecoModel->update($codigo, $dados);

        return $this->respond(['message' => 'Endereço atualizado com sucesso.']);
    }

    public function delete($codigo = null)
    {
        $this->enderecoModel->update($codigo, ['dataDesativadoEndereco' => date('Y-m-d H:i:s')]);

        return $this->respond(['message' => 'Endereço desativado com sucesso.']);
    }
}
