<?php

namespace App\Models;

use CodeIgniter\Model;

class BairroModel extends Model {
    protected $table = 'Bairro';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['bairro', 'dataCadastro'];
}
