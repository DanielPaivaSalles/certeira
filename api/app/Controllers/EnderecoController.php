<?php

namespace App\Controllers;

use App\Models\EnderecoModel;
use App\Controllers\RuaController;
use App\Controllers\BairroController;
use App\Controllers\CidadeController;
use CodeIgniter\RESTful\ResourceController;

class EnderecoController extends ResourceController
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

    //Metodo para criar um objeto de instância da tabela
    public function toArray($codigo = null) {
        $endereco = $this->enderecoModel->find($codigo);

        if (!$endereco) {
            return null;
        }

        $rua = $this->ruaController->toArray($endereco['codigoRua']);
        $bairro = $this->bairroController->toArray($endereco['codigoBairro']);
        $cidade = $this->cidadeController->toArray($endereco['codigoCidade']);

        return [
            'codigo' => $endereco['codigo'],
            'codigoRua' => $endereco['codigoRua'],
            'numero' => $endereco['numero'],
            'codigoBairro' => $endereco['codigoBairro'],
            'codigoCidade' => $endereco['codigoCidade'],
            'cep' => $endereco['cep'],
            'dataCadastro' => $endereco['dataCadastro'],
            'rua' => $rua,
            'bairro' => $bairro,
            'cidade' => $cidade,
        ];
    }

    //Metodo para criar lista de objetos
    public function index() {
        //Cria um objeto com todos os objetos da base
        $enderecos = $this->enderecoModel->findAll();

        //Lista de objetos vazia para criar o json de resposta
        $resultado = [];

        //Para cada objeto na lista de objetos
        foreach ($enderecos as $endereco) {
            //Cria uma lista de bojetos
            $resultado[] = $this->toArray($endereco['codigo']);
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
        if(empty(trim($dados['numero'])) || empty(trim($dados['cep']))) {
            return $this->failValidationErrors("Campo 'Número' e 'CEP' obrigatórios!");
        }

        //Cria os dados a serem inseridos na base
        $enderecoData = [
            'codigoRua' => $dados['codigoRua'],
            'numero' => trim($dados['numero']),
            'codigoBairro' => $dados['codigoBairro'],
            'codigoCidade' => $dados['codigoCidade'],
            'cep' => trim($dados['cep']),
            'dataCadastro' => date('Y-m-d H:i:s'),
        ];

        //Cria o insert no banco de dados
        $this->enderecoModel->insert($enderecoData);

        //Retorna um json que acabou de ser inserido
        return $this->response->setJSON($this->toArray($this->enderecoModel->getInsertID()));
    }

    //Metodo para alterar uma instância na tabela
    public function update($codigo = null) {
        //Dados recupera as informações enviadas via formulário
        $dados = $this->request->getJSON(true);

        //Verifica se os dados estão vazios. Caso sim, retorna instância não encontrada
        if($this->toArray($codigo) === null) {
            return $this->failNotFound('Endereço não encontrado!');
        }

        //Cria uma lista com os dados a serem alterados
        $enderecoData = [
            'codigoRua' => $dados['codigoRua'],
            'numero' => trim($dados['numero']),
            'codigoBairro' => $dados['codigoBairro'],
            'codigoCidade' => $dados['codigoCidade'],
            'cep' => trim($dados['cep']),
        ];

        //Cria o update de estado no banco de dados
        $this->enderecoModel->update($codigo, $enderecoData);

        //Retorna um json que acabou de ser alterado
        return $this->response->setJSON($this->toArray($codigo));
    }

    //Metodo para desativar uma instância na tabela
    public function delete($codigo = null) {
        //Se não for passado um código válido, vai retornar 'não encontrado'
        if($this->toArray($codigo) === null) {
            return $this->failNotFound('Endereço não encontrada!');
        }

        //Cria uma lista para alterar a dataDesativado
        $enderecoData = [
            'dataDesativado' => date('Y-m-d H:i:s'),
        ];

        //Cria o update de dataDesativado no banco de dados
        $this->enderecoModel->update($codigo, $enderecoData);

        //Retorna um json confirmando que foi desativado
        return $this->respond(['message' => 'Endereço desativado com sucesso.']);
    }
}











