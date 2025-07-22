<?php

namespace App\Models;

use CodeIgniter\Model;

class RuaModel extends Model {
    protected $table = 'Rua';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['rua'];

    protected $beforeInsert = ['uppercaseFields'];
    protected $beforeUpdate = ['uppercaseFields'];

    protected function uppercaseFields(array $data)
    {
        if (isset($data['data']['rua'])) {
            $data['data']['rua'] = strtoupper($data['data']['rua']);
        }

        return $data;
    }

}

