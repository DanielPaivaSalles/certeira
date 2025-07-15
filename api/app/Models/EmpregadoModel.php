<?php

namespace App\Models;

use CodeIgniter\Model;

class EmpregadoModel extends Model {
    protected $table = 'Empregado';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['nome', 'email', 'senha', 'codigoEndereco', 'dataCadastro', 'dataDesativado'];

    protected $beforeInsert = ['uppercaseFields', 'lowercaseFields'];
    protected $beforeUpdate = ['uppercaseFields', 'lowercaseFields'];

    protected function uppercaseFields(array $data)
    {
        if (isset($data['data']['nome'])) {
            $data['data']['nome'] = strtoupper($data['data']['nome']);
        }

        return $data;
    }

    protected function lowercaseFields(array $data)
    {
        if (isset($data['data']['email'])) {
            $data['data']['email'] = strtolower($data['data']['email']);
        }

        return $data;
    }
}

