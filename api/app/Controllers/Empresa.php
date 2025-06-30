<?php

namespace App\Controllers;

use App\Models\EmpresaModel;
use CodeIgniter\RESTful\ResourceController;

class Empresa extends ResourceController
{
    public function index()
    {
        $model = new EmpresaModel();
        $data = $model->findAll();

        return $this->response->setJSON($data);
    }
}
