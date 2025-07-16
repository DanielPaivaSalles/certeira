namespace App\DTOs;

class RuaDTO {
    public $codigo;
    public $rua;
    public $dataCadastro;

    public function __construct($ruaData) {
        $this->codigo = $ruaData['codigo'];
        $this->rua = $ruaData['rua'];
        $this->dataCadastro = $ruaData['dataCadastro'];
    }

    public function toArray() {
        return [
            'codigo' => $this->codigo,
            'rua' => $this->rua,
            'dataCadastro' => $this->dataCadastro,
        ];
    }
}
