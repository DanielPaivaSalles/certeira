<?php

namespace App\Models;

use CodeIgniter\Model;

class EmpresaModel extends Model {
    protected $table = 'Empresa';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['razao', 'fantasia', 'cnpj', 'im', 'codigoEndereco', 'dataCadastro', 'dataDesativado'];

    protected $beforeInsert = ['uppercaseFields'];
    protected $beforeUpdate = ['uppercaseFields'];

    protected function uppercaseFields(array $data)
    {
        if (isset($data['data']['razao'])) {
            $data['data']['razao'] = strtoupper($data['data']['razao']);
        }

        if (isset($data['data']['fantasia'])) {
            $data['data']['fantasia'] = strtoupper($data['data']['fantasia']);
        }

        return $data;
    }

}

