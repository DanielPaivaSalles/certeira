<?php

namespace App\Models;

use CodeIgniter\Model;

class CidadeModel extends Model {
    protected $table = 'Cidade';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['cidade', 'codigoEstado', 'ibge', 'dataCadastro'];

    protected $beforeInsert = ['uppercaseFields'];
    protected $beforeUpdate = ['uppercaseFields'];

    protected function uppercaseFields(array $data)
    {
        if (isset($data['data']['cidade'])) {
            $data['data']['cidade'] = strtoupper($data['data']['cidade']);
        }

        return $data;
    }
}

