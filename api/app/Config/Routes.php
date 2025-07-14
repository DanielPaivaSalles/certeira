<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

//Auth
$routes->post('auth/login', 'AuthController::login');//Autenticação

//Bairro
$routes->get('bairros', 'BairroController::index');//Lista
$routes->get('bairro/(:num)', 'BairroController::show/$1');//Busca uma empresa
$routes->post('bairro', 'BairroController::create');//Cadastra uma empresa
$routes->put('bairro/(:num)', 'BairroController::update/$1');//Altera uma empresa
$routes->delete('bairro/(:num)', 'BairroController::delete/$1');//'Deleta' uma empresa

//Empresa
$routes->get('empresas', 'Empresa::getEmpresas');//Lista
$routes->get('empresa/(:num)', 'Empresa::get/$1');//Busca uma empresa
$routes->post('empresa', 'Empresa::post');//Cadastra uma empresa
$routes->put('empresa/(:num)', 'Empresa::put/$1');//Altera uma empresa
$routes->delete('empresa/(:num)', 'Empresa::delete/$1');//'Deleta' uma empresa

