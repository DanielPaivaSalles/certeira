<?php

namespace App\Models;

use CodeIgniter\Model;

class CidadeModel extends Model
{
    protected $table = 'Cidade';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['cidade', 'codigoEstado', 'ibge', 'dataCadastroCidade'];
}

