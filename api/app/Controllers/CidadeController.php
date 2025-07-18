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

    //Metodo para criar 'json' de objeto Cidade por código
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
            'ibge' => $cidade['ibge'],
            'estado' => $estado,
        ];
    }

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $cidades = $this->cidadeModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($cidades as $cidade) {
            //Cria uma lista de bojetos
            $resultado[] = $this->toArray($cidade['codigo']);
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
        if (empty(trim($dados['cidade'])) || empty(trim($dados['ibge']))) {
            return $this->failValidationErrors("Campo 'Cidade' e 'IBGE' obrigatórios!");
        }

        //Cria os dados a serem inseridos na base
        $cidadeData = [
            'cidade' => trim($dados['cidade']),
            'codigoEstado' => $dados['codigoEstado'],
            'ibge' => trim($dados['ibge']),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        //Cria o insert no banco de dados
        $this->cidadeModel->insert($cidadeData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->cidadeModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if($this->toArray($codigo === null || empty(trim($dados['cidade'])))){
            return $this->failNotFound('Cidade não encontrada!');
        }

        //Cria uma lista com os dados a serem alterados
        $cidadeData = [
            'cidade' => trim($dados['cidade']),
            'ibge' => trim($dados['ibge']),
            'codigoEstado' => trim($dados['codigoEstado']),
        ];

        //Cria o update de bairro no banco de dados
        $this->cidadeModel->update($codigo, $cidadeData);

        //Retorna um json que acabou de ser alterado
        return $this->response->setJSON($this->toArray($this->cidadeModel->getInsertID()));
    }

    //Metodo para desativar uma instância na tabela
    public function delete($codigo = null) {
        //Se não for passado um código válido, vai retornar 'não encontrado'
        if($this->toArray($codigo === null)){
            return $this->failNotFound('Cidade não encontrada!');
        }

        //Cria uma lista para alterar a dataDesativado
        $cidadeData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        //Cria o update de dataDesativado no banco de dados
        $this->cidadeModel->update($codigo, $cidadeData);

        //Retorna um json confirmando que foi desativado
        return $this->respond(['message' => 'Cidade desativada com sucesso.']);
    }
}











