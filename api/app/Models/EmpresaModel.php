<?php

namespace App\Models;

use CodeIgniter\Model;

class EmpresaModel extends Model
{
    protected $table = 'Empresa';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['razao', 'fantasia', 'cnpj', 'im', 'codigoEndereco', 'dataCadastro', 'dataDesativado'];
}

