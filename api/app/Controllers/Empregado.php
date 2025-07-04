<?php

namespace App\Controllers;

use App\Models\EmpregadoModel;
use CodeIgniter\RESTful\ResourceController;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Empregado extends ResourceController
{
    public function index()
    {
        $model = new EmpregadoModel();
        $data = $model->findAll();

        return $this->response->setJSON($data);
    }

}

