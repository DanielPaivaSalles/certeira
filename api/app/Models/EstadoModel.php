<?php

namespace App\Models;

use CodeIgniter\Model;

class EstadoModel extends Model {
    protected $table = 'Estado';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['estado', 'uf','dataCadastro'];

    protected $beforeInsert = ['uppercaseFields'];
    protected $beforeUpdate = ['uppercaseFields'];

    protected function uppercaseFields(array $data)
    {
        if (isset($data['data']['estado'])) {
            $data['data']['estado'] = strtoupper($data['data']['estado']);
        }

        if (isset($data['data']['uf'])) {
            $data['data']['uf'] = strtoupper($data['data']['uf']);
        }

        return $data;
    }
}

