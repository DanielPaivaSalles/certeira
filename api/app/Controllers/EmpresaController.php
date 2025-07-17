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

    //Metodo para criar um objeto de instância da tabela
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

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $empresas = $this->empresaModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($empresas as $empresa) {
            return $empresa;
            //Cria uma lista de bojetos
            $resultado[] = $this->toArray($empresa['codigo']);
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
        if(empty($dados['razao'])||empty($dados['fantasia'])||empty($dados['cnpj'])||empty($dados['im'])){
            return $this->failValidationErrors("Campos 'Razão', 'Fantasia', 'CNPJ' ou 'IM' obrigatórios");
        }

        //Cria os dados a serem inseridos na base
        $empresaData = [
            'razao' => trim($dados['razao']),
            'fantasia' => trim($dados['fantasia']),
            'cnpj' => trim($dados['cnpj']),
            'im' => trim($dados['im']),
            'codigoEndereco' => $dados['codigoEndereco'],
            'dataCadastro' => date('Y-m-d H:i:s'),
            'dataDesativado' => null,
        ];

        //Cria o insert no banco de dados
        $this->empresaModel->insert($empresaData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->empresaModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if($this->toArray($codigo) === null || empty(trim($dados['razao'])) || empty(trim($dados['fantasia']))){
            return $this->failNotFound('Empresa não encontrada!');
        }

        //Cria uma lista com os dados a serem alterados
        $empresaData = [
            'razao' => trim($dados['razao']),
            'fantasia' => trim($dados['fantasia']),
            'cnpj' => trim($dados['cnpj']),
            'im' => trim($dados['im']),
            'codigoEndereco' => $dados['codigoEndereco'],
        ];

        //Cria o update de estado no banco de dados
        $this->empresaModel->update($codigo, $empresaData);

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
        $this->empresaModel->update($codigo, $empresaData);

        //Retorna um json confirmando que foi desativado
        return $this->respondCreated(['message' => 'Empresa desativada com sucesso']);
    }
}











