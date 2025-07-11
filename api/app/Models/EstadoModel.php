<?php

namespace App\Models;

use CodeIgniter\Model;

class EstadoModel extends Model {
    protected $table = 'Estado';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['estado', 'uf','dataCadastro'];
}

