import 'package:flutter/material.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/custom_selection_text.dart';
import '../../../core/widgets/custom_buttom.dart';

class EmpresaPage extends StatefulWidget {
  const EmpresaPage({super.key});

  @override
  State<EmpresaPage> createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  // Controllers empresa
  final razaoController = TextEditingController();
  final fantasiaController = TextEditingController();
  final cnpjController = TextEditingController();
  final imController = TextEditingController();
  final cadastroController = TextEditingController();

  // Controllers endereco
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final cepController = TextEditingController();
  final cadastroEnderecoController = TextEditingController();

  void incluir() {
    final dados = {
      "razao": razaoController.text,
      "fantasia": fantasiaController.text,
      "cnpj": cnpjController.text,
      "im": imController.text,
      "cadastro": cadastroController.text,
      "rua": ruaController.text,
      "numero": numeroController.text,
      "bairro": bairroController.text,
      "cidade": cidadeController.text,
      "cep": cepController.text,
      "cadastro_endereco": cadastroEnderecoController.text,
    };

    // Aqui você mandaria para a API
    print(dados);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
                      color: Colors.black87,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSelectionTitle(text: 'Empresa'),
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
                                  controller: cadastroController,
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
                      color: Colors.black87,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSelectionTitle(text: 'Endereço'),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CustomTextField(
                                  label: 'Rua',
                                  controller: ruaController,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: CustomTextField(
                                  label: 'Número',
                                  controller: numeroController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              flex: 35,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CustomTextField(
                                  label: 'Bairro',
                                  controller: bairroController,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 65,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: CustomTextField(
                                  label: 'Cidade',
                                  controller: cidadeController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CustomTextField(
                                  label: 'CEP',
                                  controller: cepController,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: CustomTextField(
                                  label: 'Cadastro',
                                  controller: cadastroEnderecoController,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      label: 'Incluir',
                      isSelected: false,
                      onTap: incluir,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      label: 'Alterar',
                      isSelected: false,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      label: 'Consultar',
                      isSelected: false,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      label: 'Excluir',
                      isSelected: false,
                      onTap: () {},
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
