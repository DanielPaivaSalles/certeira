<?php

namespace App\Controllers;

use App\Models\EmpregadoModel;
use App\Controllers\EnderecoController;
use CodeIgniter\RESTful\ResourceController;

class EmpregadoController extends ResourceController {
    protected $empregadoModel;
    protected $enderecoController;
    
    public function __construct(){
    $this->empregadoModel = new EmpregadoModel();
    $this->enderecoController = new EnderecoController();
    }

    //Metodo para criar um objeto de instância da tabela
    public function toArray($codigo = null) {
        $empregado = $this->empregadoModel->find($codigo);

        if (!$empregado) {
            return null;
        }

        $endereco = $this->enderecoController->toArray($empregado['codigoEndereco']);

        return [
            'codigo' => $empregado['codigo'],
            'nome' => $empregado['nome'],
            'email' => $empregado['email'],
            'codigoEndereco' => $empregado['codigoEndereco'],
            'dataCadastro' => $empregado['dataCadastro'],
            'dataDesativado' => $empregado['dataDesativado'],
            'endereco' => $endereco,
        ];
    }

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $empregados = $this->empregadoModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($empregados as $empregado) {
            //Cria uma lista de bojetos
            $resultado[] = $this->toArray($empregado['codigo']);
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
        if(empty($dados['nome'])||empty($dados['email'])){
            return $this->failValidationErrors("Campos 'Nome' ou 'Email' obrigatórios");
        }

        //Cria os dados a serem inseridos na base
        $empresaData = [
            'nome' => trim($dados['nome']),
            'email' => trim($dados['email']),
            'senha' => trim($dados['senha']),
            'codigoEndereco' => $dados['codigoEndereco'],
            'dataCadastro' => date('Y-m-d H:i:s'),
            'dataDesativado' => null,
        ];

        //Cria o insert no banco de dados
        $this->empregadoModel->insert($empresaData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->empregadoModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if($this->toArray($codigo) === null || empty(trim($dados['nome'])) || empty(trim($dados['email']))){
            return $this->failNotFound('Empresa não encontrada!');
        }

        //Cria uma lista com os dados a serem alterados
        $empresaData = [
            'nome' => trim($dados['nome']),
            'email' => trim($dados['email']),
            'senha' => trim($dados['senha']),
            'codigoEndereco' => $dados['codigoEndereco'],
        ];

        //Cria o update de estado no banco de dados
        $this->empregadoModel->update($codigo, $empresaData);

        //Retorna um json que acabou de ser alterado
        return $this->response->setJSON($this->toArray($codigo));
    }

    //Metodo para desativar uma instância na tabela
    public function delete($codigo = null) {
        //Se não for passado um código válido, vai retornar 'não encontrado'
        if($this->toArray($codigo) === null){
            return $this->failNotFound('Empresa não encontrada');
        }

        //Cria uma lista para alterar a dataDesativado
        $empresaData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        //Cria o update de dataDesativado no banco de dados
        $this->empregadoModel->update($codigo, $empresaData);

        //Retorna um json confirmando que foi desativado
        return $this->respondCreated(['message' => 'Empresa desativada com sucesso']);
    }
}

