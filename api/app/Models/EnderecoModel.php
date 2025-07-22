<?php

namespace App\Models;

use CodeIgniter\Model;

class EnderecoModel extends Model {
    protected $table = 'Endereco';
    protected $primaryKey = 'codigo';
    protected $allowedFields = ['codigoRua', 'numero', 'codigoBairro', 'codigoCidade', 'cep'];

}

