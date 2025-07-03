import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/widgets/custom_buttom.dart';
import 'package:flutter_app/app/core/widgets/custom_container_white.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_titulo.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_cabecalho.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_texto.dart';
import 'package:flutter_app/app/core/widgets/custom_textfield_filtro.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
import '../controllers/empresas_controller.dart';

class EmpresasPage extends StatefulWidget {
  final void Function(EmpresaModel empresa) onIncluirPressed;
  final void Function(EmpresaModel empresa) onAlterarPressed;
  final void Function(EmpresaModel empresa) onDesativarPressed;

  const EmpresasPage({
    super.key,
    required this.onIncluirPressed,
    required this.onAlterarPressed,
    required this.onDesativarPressed,
  });

  @override
  State<EmpresasPage> createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  late EmpresasController controller;
  late Future<void> futureLoad;

  @override
  void initState() {
    super.initState();

    controller = EmpresasController();

    // importante: chamamos loadEmpresas só aqui!
    futureLoad = controller.loadEmpresas();

    controller.searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: futureLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mostra loading
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar empresas: ${snapshot.error}'),
          );
        } else {
          return _buildContent();
        }
      },
    );
  }

  Widget _buildContent() {
    return CustomContainerWhite(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextTabelaTitulo(text: 'Empresas'),
          const SizedBox(height: 10),

          // Campo de filtro
          Container(
            width: 1200,
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 100,
              width: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                    label: 'Incluir',
                    isSelected: false,
                    onTap:
                        () => widget.onIncluirPressed(
                          EmpresaModel(
                            codigo: '',
                            razao: '',
                            fantasia: '',
                            cnpj: '',
                            im: '',
                            codigoEndereco: '',
                            dataCadastro: '',
                            dataDesativado: '',
                            endereco: {},
                          ),
                        ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextFieldFiltro(
                      label: 'Pesquisar',
                      controller: controller.searchController,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tabela scrollável
          SizedBox(
            height: 500,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: 1200,
                child: DataTable(
                  columns: const [
                    DataColumn(label: CustomTextTabelaCabecalho(text: 'ID')),
                    DataColumn(
                      label: CustomTextTabelaCabecalho(text: 'Razão Social'),
                    ),
                    DataColumn(
                      label: CustomTextTabelaCabecalho(text: 'Fantasia'),
                    ),
                    DataColumn(label: CustomTextTabelaCabecalho(text: 'CNPJ')),
                    DataColumn(
                      label: CustomTextTabelaCabecalho(text: 'Cidade'),
                    ),
                    DataColumn(label: CustomTextTabelaCabecalho(text: 'Ações')),
                  ],
                  rows:
                      controller.filteredEmpresas
                          .map((empresa) => _buildRow(empresa))
                          .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(EmpresaModel empresa) {
    return DataRow(
      cells: [
        DataCell(CustomTextTabelaTexto(text: empresa.codigo)),
        DataCell(CustomTextTabelaTexto(text: empresa.razao)),
        DataCell(CustomTextTabelaTexto(text: empresa.fantasia)),
        DataCell(CustomTextTabelaTexto(text: empresa.cnpj)),
        DataCell(
          CustomTextTabelaTexto(text: empresa.endereco?['cidade'] ?? ''),
        ),
        DataCell(
          Row(
            children: [
              CustomButton(
                label: '',
                isSelected: false,
                icon: Icons.edit,
                onTap: () => widget.onAlterarPressed(empresa),
              ),
              const SizedBox(width: 8),
              CustomButton(
                label: '',
                isSelected: false,
                icon: Icons.delete,
                onTap: () => widget.onDesativarPressed(empresa),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
