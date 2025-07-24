<?php

namespace App\Controllers;

use App\Models\EmpresaModel;
use App\Controllers\EnderecoController;
use CodeIgniter\RESTful\ResourceController;
use App\Helpers\ValidationHelper;

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

        // Validar campos obrigatórios
        $required_fields = ['razao', 'fantasia', 'cnpj', 'im'];
        $missing_fields = ValidationHelper::validateRequired($dados, $required_fields);

        if (!empty($missing_fields)) {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Campos obrigatórios faltando: ' . implode(', ', $missing_fields)
            ])->setStatusCode(400);
        }
        
        // Validar CNPJ
        if (!ValidationHelper::validateCNPJ($dados['cnpj'])) {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'CNPJ inválido.'
            ])->setStatusCode(400);
        }

        // Sanitizar dados
        $empresaData = [
            'razao' => ValidationHelper::sanitizeString($dados['razao']),
            'fantasia' => ValidationHelper::sanitizeString($dados['fantasia']),
            'cnpj' => ValidationHelper::sanitizeString($dados['cnpj']),
            'im' => ValidationHelper::sanitizeString($dados['im']),
            'codigoEndereco' => filter_var($dados['codigoEndereco'], FILTER_VALIDATE_INT),
            'dataCadastro' => date('d-m-Y H:i:s'),
            'dataDesativado' => null,
        ];

        try {
            $this->empresaModel->insert($empresaData);
            return $this->response->setJSON([
                'status' => true,
                'data' => $this->toArray($this->empresaModel->getInsertID())
            ]);
        } catch (\Exception $e) {
            return $this->response->setJSON([
                'status' => false,
                'mensagem' => 'Erro ao criar empresa: ' . $e->getMessage()
            ])->setStatusCode(500);
        }
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











