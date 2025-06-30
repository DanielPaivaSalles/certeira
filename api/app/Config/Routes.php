<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('empresas', 'Empresa::index');
$routes->post('empregadoLogin', 'Empregado::login');
