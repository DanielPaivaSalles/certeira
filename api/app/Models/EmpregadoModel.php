<?php

namespace App\Models;

use CodeIgniter\Model;

class EmpregadoModel extends Model
{
    protected $table = 'Empregado';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['nome', 'email', 'senha', 'codigoEndereco', 'dataCadastro', 'dataDesativado'];
}

