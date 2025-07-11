<?php

namespace App\Models;

use CodeIgniter\Model;

class RuaModel extends Model {
    protected $table = 'Rua';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['rua', 'dataCadastro'];
}

