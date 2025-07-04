import 'package:flutter/material.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
import 'package:flutter_app/app/modules/empresa/controllers/empresa_controller.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/custom_selection_title.dart';
import '../../../core/widgets/custom_buttom.dart';

class EmpresaPage extends StatefulWidget {
  final EmpresaModel? empresa;
  final VoidCallback? onCancelarPressed;

  const EmpresaPage({super.key, this.empresa, this.onCancelarPressed});

  @override
  State<EmpresaPage> createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  // Controlador da empresa
  late EmpresaController empresaController;

  //Parte da empresa
  late TextEditingController codigoController;
  late TextEditingController razaoController;
  late TextEditingController fantasiaController;
  late TextEditingController cnpjController;
  late TextEditingController imController;
  late TextEditingController codigoEnderecoController;
  late TextEditingController dataCadastroEmpresaController;
  late TextEditingController dataDesativadoEmpresaController;

  // Parte do endereço
  late TextEditingController ruaController;
  late TextEditingController numeroController;
  late TextEditingController bairroController;
  late TextEditingController cidadeController;
  late TextEditingController cepController;

  @override
  void initState() {
    super.initState();

    // Inicia o controlador da empresa
    empresaController = EmpresaController();

    //Inicia controllers de empresa
    codigoController = TextEditingController(
      text: widget.empresa?.codigo ?? '',
    );
    razaoController = TextEditingController(text: widget.empresa?.razao ?? '');
    fantasiaController = TextEditingController(
      text: widget.empresa?.fantasia ?? '',
    );
    cnpjController = TextEditingController(text: widget.empresa?.cnpj ?? '');
    imController = TextEditingController(text: widget.empresa?.im ?? '');
    codigoEnderecoController = TextEditingController(
      text: widget.empresa?.codigoEndereco ?? '',
    );
    dataCadastroEmpresaController = TextEditingController(
      text: widget.empresa?.dataCadastroEmpresa ?? '',
    );
    dataDesativadoEmpresaController = TextEditingController(
      text: widget.empresa?.dataDesativadoEmpresa ?? '',
    );

    // Inicia controllers de endereço
    ruaController = TextEditingController(
      text: widget.empresa?.endereco?.rua ?? '',
    );
    numeroController = TextEditingController(
      text: widget.empresa?.endereco?.numero ?? '',
    );
    bairroController = TextEditingController(
      text: widget.empresa?.endereco?.bairro ?? '',
    );
    cidadeController = TextEditingController(
      text: widget.empresa?.endereco?.cidade ?? '',
    );
    cepController = TextEditingController(
      text: widget.empresa?.endereco?.cep ?? '',
    );
  }

  @override
  void dispose() {
    // Dispose dos controllers de empresa
    codigoController.dispose();
    razaoController.dispose();
    fantasiaController.dispose();
    cnpjController.dispose();
    imController.dispose();
    codigoEnderecoController.dispose();
    dataCadastroEmpresaController.dispose();
    dataDesativadoEmpresaController.dispose();

    // Dispose dos controllers de endereço
    ruaController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coluna esquerda scrollável
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Container Empresa
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomSelectionTitle(text: 'Empresa'),
                            CustomSelectionTitle(
                              text:
                                  widget.empresa?.codigo.isNotEmpty == true
                                      ? widget.empresa!.codigo
                                      : '',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        CustomTextField(
                          label: 'Razão Social',
                          controller: razaoController,
                        ),
                        const SizedBox(height: 10),

                        CustomTextField(
                          label: 'Nome Fantasia',
                          controller: fantasiaController,
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CustomTextField(
                                  label: 'CNPJ',
                                  controller: cnpjController,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: CustomTextField(
                                  label: 'IM',
                                  controller: imController,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: CustomTextField(
                                  label: 'Cadastro',
                                  controller: dataCadastroEmpresaController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  // Container Endereço
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSelectionTitle(text: 'Endereço'),
                        const SizedBox(height: 10),

                        CustomTextField(
                          label: 'Rua',
                          controller: ruaController,
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'Número',
                                controller: numeroController,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomTextField(
                                label: 'Bairro',
                                controller: bairroController,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomTextField(
                                label: 'CEP',
                                controller: cepController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'Cidade',
                                controller: cidadeController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Coluna direita fixa (150 px) com botões CRUD
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      label: 'Salvar',
                      isSelected: false,
                      onTap: () async {
                        final endereco = {
                          'rua': ruaController.text,
                          'numero': numeroController.text,
                          'bairro': bairroController.text,
                          'cidade': cidadeController.text,
                          'cep': cepController.text,
                        };

                        final sucesso = await empresaController.salvarEmpresa(
                          codigo: codigoController.text,
                          razao: razaoController.text,
                          fantasia: fantasiaController.text,
                          cnpj: cnpjController.text,
                          im: imController.text,
                          codigoEndereco: codigoEnderecoController.text,
                          dataCadastroEmpresa:
                              dataCadastroEmpresaController.text,
                          dataDesativadoEmpresa:
                              dataDesativadoEmpresaController.text,
                          endereco: endereco,
                        );

                        if (sucesso) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Erro ao salvar empresa'),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      label: 'Cancelar',
                      isSelected: false,
                      onTap: () {
                        widget.onCancelarPressed!();
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
