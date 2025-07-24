<?php

namespace App\Libraries;

use CodeIgniter\Log\Handlers\BaseHandler;

class SecurityLogHandler extends BaseHandler
{
    protected $handles = ['security'];
    protected $path;
    protected $fileExtension;
    protected $dateFormat;

    public function __construct(array $config = [])
    {
        parent::__construct($config);
        
        $this->path = $config['path'] ?? WRITEPATH . 'logs/security/';
        $this->fileExtension = $config['fileExtension'] ?? 'log';
        $this->dateFormat = $config['dateFormat'] ?? 'd-m-Y H:i:s';
        
        if (!is_dir($this->path)) {
            mkdir($this->path, 0755, true);
        }
    }

    public function handle($level, $message): bool
    {
        $filename = $this->path . 'security-' . date('d-m-Y') . '.' . $this->fileExtension;
        $logMessage = '[' . date($this->dateFormat) . '] ' . strtoupper($level) . ': ' . $message . PHP_EOL;
        
        return file_put_contents($filename, $logMessage, FILE_APPEND | LOCK_EX) !== false;
    }
}
