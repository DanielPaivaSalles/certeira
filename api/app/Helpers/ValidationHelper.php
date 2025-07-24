<?php

namespace App\Helpers;

class ValidationHelper
{
    public static function sanitizeString($input)
    {
        return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
    }

    public static function validateEmail($email)
    {
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    public static function validateCNPJ($cnpj)
    {
        $cnpj = preg_replace('/\D/', '', $cnpj);
        
        if (strlen($cnpj) !== 14) {
            return false;
        }

        // Validação básica de CNPJ
        // Implementar algoritmo completo conforme necessário
        return true;
    }

    public static function validateRequired($data, $required_fields)
    {
        $missing_fields = [];
        
        foreach ($required_fields as $field) {
            if (!isset($data[$field]) || empty(trim($data[$field]))) {
                $missing_fields[] = $field;
            }
        }
        
        return $missing_fields;
    }
}
