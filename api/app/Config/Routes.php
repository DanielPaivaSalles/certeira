<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

//Auth
$routes->post('auth/login', 'AuthController::login');//Autenticação

//Estado
$routes->get('estados', 'EstadoController::index');//Lista os estados
$routes->get('estado/(:num)', 'EstadoController::show/$1');//Busca um estado
$routes->post('estado', 'EstadoController::create');//Cadastra um estado
$routes->put('estado/(:num)', 'EstadoController::update/$1');//Altera um estado
//$routes->delete('estado/(:num)', 'EstadoController::delete/$1');//'Deleta' um estado

//Cidade
$routes->get('cidades', 'CidadeController::index');//Lista os cidades
$routes->get('cidade/(:num)', 'CidadeController::show/$1');//Busca um cidade
$routes->post('cidade', 'CidadeController::create');//Cadastra um cidade
$routes->put('cidade/(:num)', 'CidadeController::update/$1');//Altera um cidade
//$routes->delete('bairro/(:num)', 'CidadeController::delete/$1');//'Deleta' um cidade

//Bairro
$routes->get('bairros', 'BairroController::index');//Lista os bairros
$routes->get('bairro/(:num)', 'BairroController::show/$1');//Busca um bairro
$routes->post('bairro', 'BairroController::create');//Cadastra um bairro
$routes->put('bairro/(:num)', 'BairroController::update/$1');//Altera um bairro
//$routes->delete('bairro/(:num)', 'BairroController::delete/$1');//'Deleta' um bairro

//Rua
$routes->get('ruas', 'RuaController::index');//Lista as ruas
$routes->get('rua/(:num)', 'RuaController::show/$1');//Busca uma rua
$routes->post('rua', 'RuaController::create');//Cadastra uma rua
$routes->put('rua/(:num)', 'RuaController::update/$1');//Altera uma rua
$routes->delete('rua/(:num)', 'RuaController::delete/$1');//'Deleta' uma rua

//Endereco
$routes->get('enderecos', 'EnderecoController::index');//Lista os enderecos
$routes->get('endereco/(:num)', 'EnderecoController::show/$1');//Busca um endereco
$routes->post('endereco', 'EnderecoController::create');//Cadastra um endereco
$routes->put('endereco/(:num)', 'EnderecoController::update/$1');//Altera um endereco
$routes->delete('endereco/(:num)', 'EnderecoController::delete/$1');//'Deleta' um endereco

//Empresa
$routes->get('empresas', 'EmpresaController::index');//Lista as empresas
$routes->get('empresa/(:num)', 'EmpresaController::show/$1');//Busca uma empresa
$routes->post('empresa', 'EmpresaController::create');//Cadastra uma empresa
$routes->put('empresa/(:num)', 'EmpresaController::update/$1');//Altera uma empresa
$routes->delete('empresa/(:num)', 'EmpresaController::delete/$1');//'Deleta' uma empresa

//Empregado
$routes->get('empregados', 'EmpregadoController::index');//Lista os empregados
$routes->get('empregado/(:num)', 'EmpregadoController::show/$1');//Busca um empregado
$routes->post('empregado', 'EmpregadoController::create');//Cadastra um empregado
$routes->put('empregado/(:num)', 'EmpregadoController::update/$1');//Altera um empregado
$routes->delete('empregado/(:num)', 'EmpregadoController::delete/$1');//'Deleta' um empregado

