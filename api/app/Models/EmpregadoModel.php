<?php

namespace App\Models;

use CodeIgniter\Model;

class EmpregadoModel extends Model
{
    protected $table = 'Empregado';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['nome', 'email', 'senha', 'codigo_endereco', 'data_cadastro', 'data_demissao'];
}

