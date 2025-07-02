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
    public function index()
    {
        $empresaModel = new EmpresaModel();
        $enderecoModel = new EnderecoModel();
        $ruaModel = new RuaModel();
        $bairroModel = new BairroModel();
        $cidadeModel = new CidadeModel();
        $estadoModel = new EstadoModel();

        $empresas = $empresaModel->findAll();

        foreach ($empresas as &$empresa) {

            $endereco = $enderecoModel
                ->where('codigo', $empresa['codigoEndereco'])
                ->first();

            if ($endereco) {
                // Pega Rua
                $rua = $ruaModel
                    ->where('codigo', $endereco['codigoRua'])
                    ->first();

                // Pega Bairro
                $bairro = $bairroModel
                    ->where('codigo', $endereco['codigoBairro'])
                    ->first();

                // Pega Cidade
                $cidade = $cidadeModel
                    ->where('codigo', $endereco['codigoCidade'])
                    ->first();

                //Pega estado
                $estado = $estadoModel
                    ->where('codigo', $cidade['codigoEstado'])
                    ->first();

                $enderecoCompleto = [
                    'codigo'          => $endereco['codigo'],
                    'numero'          => $endereco['numero'],
                    'cep'             => $endereco['cep'],
                    'rua'             => $rua['rua'],
                    'bairro'          => $bairro['bairro'],
                    'cidade'          => $cidade['cidade'],
                    'estado'          => $estado['estado'],
                    'uf'              => $estado['uf'],
                    'dataCadastro'    => $endereco['dataCadastro'],
                    'dataDesativado'  => $endereco['dataDesativado'],
                ];

                $empresa['endereco'] = $enderecoCompleto;
            } else {
                $empresa['endereco'] = null;
            }
        }

        return $this->response->setJSON($empresas);
    }
}
