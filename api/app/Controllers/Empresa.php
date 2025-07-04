<?php

namespace App\Controllers;

use App\Models\BairroModel;
use App\Models\CidadeModel;
use App\Models\EmpresaModel;
use App\Models\EnderecoModel;
use App\Models\EstadoModel;
use App\Models\RuaModel;
use CodeIgniter\RESTful\ResourceController;

class Empresa extends ResourceController
{
    protected $empresaModel;
    protected $enderecoModel;
    protected $ruaModel;
    protected $bairroModel;
    protected $cidadeModel;
    protected $estadoModel;
    
    public function __construct(){
    $this->empresaModel = new EmpresaModel();
    $this->enderecoModel = new EnderecoModel();
    $this->ruaModel = new RuaModel();
    $this->bairroModel = new BairroModel();
    $this->cidadeModel = new CidadeModel();
    $this->estadoModel = new EstadoModel();

    }

    public function getEmpresas()
    {
        // Busca TODAS as empresas
        $empresas = $this->empresaModel->findAll();

        $resultado = [];

        foreach ($empresas as $empresa) {
            $cidadeNome = '';

            if (!empty($empresa['codigoEndereco'])) {
                // Busca o endereço
                $endereco = $this->enderecoModel
                    ->where('codigo', $empresa['codigoEndereco'])
                    ->first();

                if ($endereco && !empty($endereco['codigoCidade'])) {
                    // Busca a cidade
                    $cidade = $this->cidadeModel
                        ->where('codigo', $endereco['codigoCidade'])
                        ->first();

                    if ($cidade) {
                        $cidadeNome = $cidade['cidade'];
                    }
                }
            }

            // Monta o array simplificado
            $resultado[] = [
                'codigo'    => $empresa['codigo'],
                'razao'     => $empresa['razao'],
                'fantasia'  => $empresa['fantasia'],
                'cnpj'      => $empresa['cnpj'],
                'cidade'    => $cidadeNome,
            ];
        }

        return $this->response->setJSON($resultado);
    }

    public function get($codigo = null)
    {
        $empresa = $this->empresaModel->where('codigo', $codigo)->first();
        if(!$empresa){
            return $this->failNotFound('Empresa não encontrada');
        }

        $endereco = $this->enderecoModel
            ->where('codigo', $empresa['codigoEndereco'])
            ->first();

        $rua = $this->ruaModel
            ->where('codigo', $endereco['codigoRua'])
            ->first();

        $bairro = $this->bairroModel
            ->where('codigo', $endereco['codigoBairro'])
            ->first();

        $cidade = $this->cidadeModel
            ->where('codigo', $endereco['codigoCidade'])
            ->first();

        $enderecoCompleto = [
            'codigo'          => $endereco['codigo']??null,
            'numero'          => $endereco['numero']??null,
            'cep'             => $endereco['cep']??null,
            'rua'             => $rua['rua']??null,
            'bairro'          => $bairro['bairro']??null,
            'cidade'          => $cidade['cidade']??null,
            'dataCadastroEndereco'    => $endereco['dataCadastroEndereco']??null,
            'dataDesativadoEndereco'  => $endereco['dataDesativadoEndereco']??null,
        ];

        $empresa['endereco'] = $enderecoCompleto;

        return $this->response->setJSON($empresa);
    }

    public function post()
    {
        $dados = $this->request->getJSON(true);

        if(empty($dados['razao'])||empty($dados['fantasia'])||empty($dados['cnpj'])||empty($dados['im'])){
            return $this->failValidationErrors("Campos 'Razão', 'Fantasia', 'CNPJ' ou 'IM' obrigatórios");
        }

        if(empty($dados['endereco']['rua'])||empty($dados['endereco']['numero'])||empty($dados['endereco']['bairro'])||empty($dados['endereco']['cidade'])||empty($dados['endereco']['cep'])){
            return $this->failValidationErrors("Campos 'Rua', 'Numero', 'Bairro', 'Cidade' ou 'CEP' obrigatórios");
        }

        /**
         * ==========================
         * RUAS
         * ==========================
         */
        $ruaNome = trim($dados['endereco']['rua'] ?? '');
        $codigoRua = null;

        if (!empty($ruaNome)) {
            $ruaExistente = $this->ruaModel->where('rua', $ruaNome)->first();

            if ($ruaExistente) {
                $codigoRua = $ruaExistente['codigo'];
            } else {
                $this->ruaModel->insert(['rua' => $ruaNome]);
                $codigoRua = $this->ruaModel->getInsertID();
            }
        } else {
            $codigoRua = 0;
        }

        /**
         * ==========================
         * BAIRROS
         * ==========================
         */
        $bairroNome = trim($dados['endereco']['bairro'] ?? '');
        $codigoBairro = null;

        if (!empty($bairroNome)) {
            $bairroExistente = $this->bairroModel->where('bairro', $bairroNome)->first();

            if ($bairroExistente) {
                $codigoBairro = $bairroExistente['codigo'];
            } else {
                $this->bairroModel->insert(['bairro' => $bairroNome]);
                $codigoBairro = $this->bairroModel->getInsertID();
            }
        } else {
            $codigoBairro = 0;
        }

        /**
         * ==========================
         * CIDADES
         * ==========================
         */
        $cidadeNome = trim($dados['endereco']['cidade'] ?? '');
        $codigoCidade = null;

        if (!empty($cidadeNome)) {
            $cidadeExistente = $this->cidadeModel->where('cidade', $cidadeNome)->first();

            if ($cidadeExistente) {
                $codigoCidade = $cidadeExistente['codigo'];
            } else {
                $this->cidadeModel->insert(['cidade' => $cidadeNome]);
                $codigoCidade = $this->cidadeModel->getInsertID();
            }
        } else {
            $codigoCidade = 0;
        }

        /**
         * ==========================
         * ENDEREÇO
         * ==========================
         */
        $enderecoData = [
            'codigoRua'     => $codigoRua,
            'numero'        => $dados['endereco']['numero'] ?? null,
            'codigoBairro'  => $codigoBairro,
            'codigoCidade'  => $codigoCidade,
            'cep'           => $dados['endereco']['cep'] ?? null,
        ];

        $this->enderecoModel->insert($enderecoData);
        $codigoEndereco = $this->enderecoModel->getInsertID();

        /**
         * ==========================
         * EMPRESA
         * ==========================
         */
        $empresaData = [
            'razao'            => $dados['razao']??null,
            'fantasia'         => $dados['fantasia']??null,
            'cnpj'             => $dados['cnpj']??null,
            'im'               => $dados['im']??null,
            'codigoEndereco'   => $codigoEndereco,
            'dataCadastroEmpresa'   => $dados['dataCadastroEmpresa']??null,
            'dataDesativado'   => null,
        ];

        $this->empresaModel->insert($empresaData);

        return $this->respondCreated(['message' => 'Empresa criada com sucesso']);
    }

    public function put($codigo = null)
    {
        $dados = $this->request->getJSON(true);

        if(empty($dados['razao'])||empty($dados['fantasia'])||empty($dados['cnpj'])||empty($dados['im'])){
            return $this->failValidationErrors("Campos 'Razão', 'Fantasia', 'CNPJ' ou 'IM' obrigatórios");
        }

        if(empty($dados['endereco']['rua'])||empty($dados['endereco']['numero'])||empty($dados['endereco']['bairro'])||empty($dados['endereco']['cidade'])||empty($dados['endereco']['cep'])){
            return $this->failValidationErrors("Campos 'Rua', 'Numero', 'Bairro', 'Cidade' ou 'CEP' obrigatórios");
        }

        $empresa = $this->empresaModel->where('codigo', $codigo)->first();

        if(!$empresa){
            return $this->failNotFound('Empresa não encontrada');
        }

        /**
         * ==========================
         * RUAS
         * ==========================
         */
        $ruaNome = trim($dados['endereco']['rua']??'');
        $codigoRua = null;

        if (!empty($ruaNome)) {
            $ruaExistente = $this->ruaModel->where('rua', $ruaNome)->first();

            if ($ruaExistente) {
                $codigoRua = $ruaExistente['codigo'];
            } else {
                $this->ruaModel->insert(['rua' => $ruaNome]);
                $codigoRua = $this->ruaModel->getInsertID();
            }
        } else {
            $codigoRua = 0;
        }

        /**
         * ==========================
         * BAIRROS
         * ==========================
         */
        $bairroNome = trim($dados['endereco']['bairro']??'');
        $codigoBairro = null;

        if (!empty($bairroNome)) {
            $bairroExistente = $this->bairroModel->where('bairro', $bairroNome)->first();

            if ($bairroExistente) {
                $codigoBairro = $bairroExistente['codigo'];
            } else {
                $this->bairroModel->insert(['bairro' => $bairroNome]);
                $codigoBairro = $this->bairroModel->getInsertID();
            }
        } else {
            $codigoBairro = 0;
        }

        /**
         * ==========================
         * CIDADES
         * ==========================
         */
        $cidadeNome = trim($dados['endereco']['cidade']??'');
        $codigoCidade = null;

        if (!empty($cidadeNome)) {
            $cidadeExistente = $this->cidadeModel->where('cidade', $cidadeNome)->first();

            if ($cidadeExistente) {
                $codigoCidade = $cidadeExistente['codigo'];
            } else {
                $this->cidadeModel->insert(['cidade' => $cidadeNome]);
                $codigoCidade = $this->cidadeModel->getInsertID();
            }
        } else {
            $codigoCidade = 0;
        }

        /**
         * ==========================
         * ENDEREÇO
         * ==========================
         */

        $codigoEndereco = $dados['codigoEndereco'];

        $enderecoData = [
            'codigoRua'     => $codigoRua,
            'numero'        => $dados['endereco']['numero']??null,
            'codigoBairro'  => $codigoBairro,
            'codigoCidade'  => $codigoCidade,
            'cep'           => $dados['endereco']['cep'] ?? null,
        ];

        $this->enderecoModel->update($codigoEndereco, $enderecoData);

        /**
         * ==========================
         * EMPRESA
         * ==========================
         */

        $empresaData = [
            'razao'            => $dados['razao']??null,
            'fantasia'         => $dados['fantasia']??null,
            'cnpj'             => $dados['cnpj']??null,
            'im'               => $dados['im']??null,
            'codigoEndereco'   => $codigoEndereco,
            'dataCadastroEmpresa'   => $dados['dataCadastroEmpresa']??null,
            'dataDesativadoEmpresa'   => $dados['dataDesativadoEmpresa']??null,
        ];

        $this->empresaModel->update($codigo, $empresaData);

        return $this->respondCreated(['message' => 'Empresa alterada com sucesso']);
    }

    public function delete($codigo = null)
    {
        $empresa = $this->empresaModel->where('codigo', $codigo)->first();

        if(!$empresa){
            return $this->failNotFound('Empresa não encontrada');
        }

        /**
         * ==========================
         * EMPRESA
         * ==========================
         */

        $empresaData = [
            'dataDesativadoEmpresa'   => $dados['dataDesativadoEmpresa']??null,
        ];

        $this->empresaModel->update($codigo, $empresaData);

        return $this->respondCreated(['message' => 'Empresa desativada com sucesso']);
    }

}

