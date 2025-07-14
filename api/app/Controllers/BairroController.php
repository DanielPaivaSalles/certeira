<?php

namespace App\Controllers;

use App\Models\BairroModel;
use CodeIgniter\RESTful\ResourceController;

class BairroController extends ResourceController {
    protected $bairroModel;

    public function __construct() {
        $this->bairroModel = new BairroModel();
    }

    //Metodo para criar 'json' de objeto Bairro por código
    public function toArray($codigo = null) {
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

    //Metodo para criar lista de bairros
    public function index() {
        //Cria um objeto com todos os bairros da base
        $bairros = $this->bairroModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada bairro dentro de bairros
        foreach ($bairros as $bairro) {
            //Cria uma lista do objeto bairro
            $resultado[] = [
                'codigo' => $bairro['codigo'],
                'bairro' => $bairro['bairro'],
                'dataCadastro' => $bairro['dataCadastro'],
            ];
        }

        //Depois de criada a lista de bairros, é criado um json para a resposta da requisição
        return $this->response->setJSON($resultado);
    }

    //Metodo para retornar o json do objeto específico solicitado
    public function show($codigo = null) {
        return $this->response->setJSON($this->toArray($codigo));
    }

    //Metodo para criar uma instância na tabela bairro
    public function create() {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se o campo bairro esta vazio. Caso sim, retorna um pedido de incluir o bairro
        if(empty(trim($dados['bairro']))){
            return $this->failValidationErrors("Campo 'Bairro' obrigatório!");
        }

        //Cria uma lista de dados de bairro
        $bairroData = [
            'bairro' => $dados['bairro'],
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        //Cria o insert de bairro no banco de dados
        $this->bairroModel->insert($bairroData);

        //Retorna um json do bairro que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->bairroModel->getInsertID()));
    }

    public function update($codigo = null) {
        $dados = $this->request->getJSON(true);

        if ($this->toArray($codigo) === null || empty(trim($dados['bairro']))) {
            return $this->failNotFound('Bairro não encontrado!');
        }

        $bairroData = [
            'bairro' => trim($dados['bairro']),
        ];

        $this->bairroModel->update($codigo, $bairroData);

        return $this->response->setJSON($this->toArray($this->bairroModel->getInsertID()));
    }

    public function delete($codigo = null) {
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











