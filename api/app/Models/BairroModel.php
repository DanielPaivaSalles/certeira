<?php

namespace App\Models;

use CodeIgniter\Model;

class BairroModel extends Model {
    protected $table = 'Bairro';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['bairro', 'dataCadastro'];

    protected $beforeInsert = ['uppercaseFields'];
    protected $beforeUpdate = ['uppercaseFields'];

    protected function uppercaseFields(array $data)
    {
        if (isset($data['data']['bairro'])) {
            $data['data']['bairro'] = strtoupper($data['data']['bairro']);
        }

        return $data;
    }
}
