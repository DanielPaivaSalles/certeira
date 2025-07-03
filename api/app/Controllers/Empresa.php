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
    public function get($codigo = null)
    {
        $empresaModel = new EmpresaModel();
        $enderecoModel = new EnderecoModel();
        $ruaModel = new RuaModel();
        $bairroModel = new BairroModel();
        $cidadeModel = new CidadeModel();

        $empresa = $empresaModel->where('codigo', $codigo)->first();
        if(!$empresa){
            return $this->failNotFound('Empresa não encontrada');
        }

        $endereco = $enderecoModel
            ->where('codigo', $empresa['codigoEndereco'])
            ->first();

        $rua = $ruaModel
            ->where('codigo', $endereco['codigoRua'])
            ->first();

        $bairro = $bairroModel
            ->where('codigo', $endereco['codigoBairro'])
            ->first();

        $cidade = $cidadeModel
            ->where('codigo', $endereco['codigoCidade'])
            ->first();

        $enderecoCompleto = [
            'codigo'          => $endereco['codigo']??null,
            'numero'          => $endereco['numero']??null,
            'cep'             => $endereco['cep']??null,
            'rua'             => $rua['rua']??null,
            'bairro'          => $bairro['bairro']??null,
            'cidade'          => $cidade['cidade']??null,
            'dataCadastro'    => $endereco['dataCadastro']??null,
            'dataDesativado'  => $endereco['dataDesativado']??null,
        ];

        $empresa['endereco'] = $enderecoCompleto;

        return $this->response->setJSON($empresa);
    }

    public function post()
    {
        $empresaModel = new EmpresaModel();
        $enderecoModel = new EnderecoModel();
        $ruaModel = new RuaModel();
        $bairroModel = new BairroModel();
        $cidadeModel = new CidadeModel();

        $dados = $this->request->getJSON(true);

        if(empty($dados['razao'])||empty($dados['fantasia'])||empty($dados['cnpj'])||empty($dados['im'])){
            return $this->failValidationErrors("Campos 'Razão', 'Fantasia', 'CNPJ' ou 'IM' obrigatórios");
        }

        if(empty($dados['rua'])||empty($dados['numero'])||empty($dados['bairro'])||empty($dados['cidade'])||empty($dados['cep'])){
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
            $ruaExistente = $ruaModel->where('rua', $ruaNome)->first();

            if ($ruaExistente) {
                $codigoRua = $ruaExistente['codigo'];
            } else {
                $ruaModel->insert(['rua' => $ruaNome]);
                $codigoRua = $ruaModel->getInsertID();
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
            $bairroExistente = $bairroModel->where('bairro', $bairroNome)->first();

            if ($bairroExistente) {
                $codigoBairro = $bairroExistente['codigo'];
            } else {
                $bairroModel->insert(['bairro' => $bairroNome]);
                $codigoBairro = $bairroModel->getInsertID();
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
            $cidadeExistente = $cidadeModel->where('cidade', $cidadeNome)->first();

            if ($cidadeExistente) {
                $codigoCidade = $cidadeExistente['codigo'];
            } else {
                $cidadeModel->insert(['cidade' => $cidadeNome]);
                $codigoCidade = $cidadeModel->getInsertID();
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

        $enderecoModel->insert($enderecoData);
        $codigoEndereco = $enderecoModel->getInsertID();

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
            'dataCadastro'   => $dados['dataCadastro']??null,
            'dataDesativado'   => null,
        ];

        $empresaModel->insert($empresaData);

        return $this->respondCreated(['message' => 'Empresa criada com sucesso']);
    }

    public function put($codigo = null)
    {
        $empresaModel = new EmpresaModel();
        $enderecoModel = new EnderecoModel();
        $ruaModel = new RuaModel();
        $bairroModel = new BairroModel();
        $cidadeModel = new CidadeModel();

        $dados = $this->request->getJSON(true);

        if(empty($dados['razao'])||empty($dados['fantasia'])||empty($dados['cnpj'])||empty($dados['im'])){
            return $this->failValidationErrors("Campos 'Razão', 'Fantasia', 'CNPJ' ou 'IM' obrigatórios");
        }

        if(empty($dados['rua'])||empty($dados['numero'])||empty($dados['bairro'])||empty($dados['cidade'])||empty($dados['cep'])){
            return $this->failValidationErrors("Campos 'Rua', 'Numero', 'Bairro', 'Cidade' ou 'CEP' obrigatórios");
        }

        $empresa = $empresaModel->where('codigo', $codigo)->first();

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
            $ruaExistente = $ruaModel->where('rua', $ruaNome)->first();

            if ($ruaExistente) {
                $codigoRua = $ruaExistente['codigo'];
            } else {
                $ruaModel->insert(['rua' => $ruaNome]);
                $codigoRua = $ruaModel->getInsertID();
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
            $bairroExistente = $bairroModel->where('bairro', $bairroNome)->first();

            if ($bairroExistente) {
                $codigoBairro = $bairroExistente['codigo'];
            } else {
                $bairroModel->insert(['bairro' => $bairroNome]);
                $codigoBairro = $bairroModel->getInsertID();
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
            $cidadeExistente = $cidadeModel->where('cidade', $cidadeNome)->first();

            if ($cidadeExistente) {
                $codigoCidade = $cidadeExistente['codigo'];
            } else {
                $cidadeModel->insert(['cidade' => $cidadeNome]);
                $codigoCidade = $cidadeModel->getInsertID();
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

        $enderecoModel->update($codigoEndereco, $enderecoData);

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
            'dataCadastro'   => $dados['dataCadastro']??null,
            'dataDesativado'   => $dados['dataDesativado']??null,
        ];

        $empresaModel->update($codigo, $empresaData);

        return $this->respondCreated(['message' => 'Empresa alterada com sucesso']);
    }
}
