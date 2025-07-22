<?php

namespace App\Controllers;

use App\Models\EstadoModel;
use CodeIgniter\RESTful\ResourceController;

class EstadoController extends ResourceController {
    protected $estadoModel;

    public function __construct() {
        $this->estadoModel = new EstadoModel();
    }

    //Metodo para criar um objeto de instância da tabela
    public function toArray($codigo = null) {
        $estado = $this->estadoModel->find($codigo);

        if (!$estado) {
            return null;
        }

        return [
            'codigo' => $estado['codigo'],
            'estado' => $estado['estado'],
            'uf' => $estado['uf'],
        ];
    }

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $estados = $this->estadoModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($estados as $estado) {
            //Cria uma lista de bojetos
            $resultado[] = $this->toArray($estado['codigo']);
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
        if(empty($dados['estado'])){
            return $this->failValidationErrors("Campo 'Estado' obrigatório!");
        }

        //Cria os dados a serem inseridos na base
        $estadoData = [
            'estado' => trim($dados['estado']),
            'uf' => $dados['uf'],
        ];

        //Cria o insert no banco de dados
        $this->estadoModel->insert($estadoData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->estadoModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if ($this->toArray($codigo) === null || empty(trim($dados['estado']))) {
            return $this->failNotFound('Estado não encontrado!');
        }

        //Cria uma lista com os dados a serem alterados
        $estadoData = [
            'estado' => trim($dados['estado']),
            'uf' => trim($dados['uf']),
        ];

        //Cria o update de estado no banco de dados
        $this->estadoModel->update($codigo, $estadoData);

        //Retorna um json que acabou de ser alterado
        return $this->response->setJSON($this->toArray($codigo));
    }

}











