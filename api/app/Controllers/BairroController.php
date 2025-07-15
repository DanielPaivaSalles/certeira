<?php

namespace App\Controllers;

use App\Models\BairroModel;
use CodeIgniter\RESTful\ResourceController;

class BairroController extends ResourceController {
    protected $bairroModel;

    public function __construct() {
        $this->bairroModel = new BairroModel();
    }

    //Metodo para criar um objeto de instância da tabela
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

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $bairros = $this->bairroModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($bairros as $bairro) {
            //Cria uma lista de bojetos
            $resultado[] = $this->toArray($bairro['codigo']);
        }

        //Depois de criada a lista de objetos, é criado um json para a resposta da requisição
        return $this->response->setJSON($resultado);
    }

    //Metodo para retornar o json do objeto específico solicitado
    public function show($codigo = null) {
        return $this->response->setJSON($this->toArray($codigo));
    }

    //Metodo para criar uma instância na tabela
    public function create() {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna um pedido de incluir eles
        if(empty(trim($dados['bairro']))){
            return $this->failValidationErrors("Campo 'Bairro' obrigatório!");
        }

        //Cria os dados a serem inseridos na base
        $bairroData = [
            'bairro' => $dados['bairro'],
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        //Cria o insert no banco de dados
        $this->bairroModel->insert($bairroData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->bairroModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if ($this->toArray($codigo) === null || empty(trim($dados['bairro']))) {
            return $this->failNotFound('Bairro não encontrado!');
        }

        //Cria uma lista com os dados a serem alterados
        $bairroData = [
            'bairro' => trim($dados['bairro']),
        ];

        //Cria o update de bairro no banco de dados
        $this->bairroModel->update($codigo, $bairroData);

        //Retorna um json que acabou de ser alterado
        return $this->response->setJSON($this->toArray($codigo));
    }

    //Metodo para desativar uma instância na tabela
    public function delete($codigo = null) {
        //Se não for passado um código válido, vai retornar 'não encontrado'
        if ($this->toArray($codigo) === null) {
            return $this->failNotFound('Bairro não encontrado!');
        }

        //Cria uma lista para alterar a dataDesativado
        $bairroData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        //Cria o update de dataDesativado no banco de dados
        $this->bairroModel->update($codigo, $bairroData);

        //Retorna um json confirmando que foi desativado
        return $this->respond(['message' => 'Bairro desativada com sucesso.']);
    }
}











