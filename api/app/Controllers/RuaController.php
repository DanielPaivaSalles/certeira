<?php

namespace App\Controllers;

use App\Models\RuaModel;
use App\DTOs\RuaDTO;
use CodeIgniter\RESTful\ResourceController;

class RuaController extends ResourceController {
    protected $ruaModel;

    public function __construct() {
        $this->ruaModel = new RuaModel();
    }

    //Metodo para criar um objeto de instância da tabela
    public function toArray($codigo = null) {
        $rua = $this->ruaModel->find($codigo);

        if (!$rua) {
            return null;
        }

        return [
            'codigo' => $rua['codigo'],
            'rua' => $rua['rua'],
            'dataCadastro' => $rua['dataCadastro'],
        ];
    }

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $ruas = $this->ruaModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($ruas as $rua) {
            //Cria uma lista de bojetos
            $ruaData = $this->toArray($rua['codigo']);

            $resultado[] = $ruaData;
        }

        //Depois de criada a lista de objetos, é criado um json para a resposta da requisição
        return $this->response->setJSON($resultado);
    }

    //Metodo para retornar o json do objeto específico solicitado
    public function show($codigo = null) {
        //Procura pela instância na base. Se não encontrar, retorna uma mensagem
        $rua = $this->ruaModel->find($codigo);
        if(!$rua){
            return $this->failNotFound('Rua não encontrada');
        }

        //Se encontrar, retorna um Data Transform Objeto da instância
        $dto = new RuaDTO($rua);
        return $this->respond($dto->toArray());
    }

    //Metodo para criar uma instância na tabela
    public function create() {
        //Regras de validação dos dados
        $rules = [
            'rua' => 'required|max_lenght[100]'
        ];

        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        if(!$this->validate($rules)){
            return $this->failValidationErrors($this->validator->getErrors());

        };

        //Cria os dados a serem inseridos na base
        $ruaData = [
            'rua' => trim($dados['rua']),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        //Cria o insert no banco de dados
        $this->ruaModel->insert($ruaData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->ruaModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if ($this->toArray($codigo) === null || empty(trim($dados['rua']))) {
            return $this->failNotFound('Rua não encontrada!');
        }

        //Cria uma lista com os dados a serem alterados
        $ruaData = [
            'rua' => trim($dados['rua']),
        ];

        //Cria o update de estado no banco de dados
        $this->ruaModel->update($codigo, $ruaData);

        //Retorna um json que acabou de ser alterado
        return $this->response->setJSON($this->toArray($codigo));
    }

    //Metodo para desativar uma instância na tabela
    public function delete($codigo = null) {
        //Se não for passado um código válido, vai retornar 'não encontrado'
        if ($this->toArray($codigo) === null) {
            return $this->failNotFound('Rua não encontrada!');
        }

        //Cria uma lista para alterar a dataDesativado
        $ruaData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        //Cria o update de dataDesativado no banco de dados
        $this->ruaModel->update($codigo, $ruaData);

        //Retorna um json confirmando que foi desativado
        return $this->respond(['message' => 'Rua desativada com sucesso.']);
    }
}











