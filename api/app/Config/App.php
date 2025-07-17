<?php

namespace Config;

use CodeIgniter\Config\BaseConfig;

class App extends BaseConfig
{
    public string $baseURL;

    public function __construct()
    {
        parent::__construct();

        $this->baseURL = rtrim(getenv('app.baseURL'), '/') . '/';
    }

    public bool $forceGlobalSecureRequests = false;

    public bool $CSPEnabled = false;

    public array $allowedHostnames = [];

    public string $indexPage = 'index.php';

    public string $uriProtocol = 'REQUEST_URI';

    public string $permittedURIChars = 'a-z 0-9~%.:_\-';

    public string $defaultLocale = 'en';

    public bool $negotiateLocale = false;

    public array $supportedLocales = ['en'];

    public string $appTimezone = 'UTC';

    public string $charset = 'UTF-8';

    public array $proxyIPs = [];

}
