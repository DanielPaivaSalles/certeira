<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

//Empresa
$routes->get('empresa/(:num)', 'Empresa::get/$1');
$routes->post('empresa', 'Empresa::post');
$routes->put('empresa/(:num)', 'Empresa::put/$1');
//Empresas
$routes->get('empresas', 'Empresa::index');

$routes->post('empregadoLogin', 'Empregado::login');
