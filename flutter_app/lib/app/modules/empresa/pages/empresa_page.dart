import 'package:flutter/material.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
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
  late TextEditingController codigoController;
  late TextEditingController razaoController;
  late TextEditingController fantasiaController;
  late TextEditingController cnpjController;
  late TextEditingController imController;
  late TextEditingController codigoEnderecoController;
  late TextEditingController dataCadastroController;
  late TextEditingController dataDesativadoController;

  @override
  void initState() {
    super.initState();

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
    dataCadastroController = TextEditingController(
      text: widget.empresa?.dataCadastro ?? '',
    );
    dataDesativadoController = TextEditingController(
      text: widget.empresa?.dataDesativado ?? '',
    );
  }

  @override
  void dispose() {
    codigoController.dispose();
    razaoController.dispose();
    fantasiaController.dispose();
    cnpjController.dispose();
    imController.dispose();
    codigoEnderecoController.dispose();
    dataCadastroController.dispose();
    dataDesativadoController.dispose();
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
                                      : 'Novo',
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
                                  controller: dataCadastroController,
                                ),
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
                      onTap: () {
                        // salvar lógica aqui
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
