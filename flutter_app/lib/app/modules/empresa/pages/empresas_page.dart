import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/widgets/custom_buttom.dart';
import 'package:flutter_app/app/core/widgets/custom_container_white.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_titulo.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_cabecalho.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_texto.dart';
import 'package:flutter_app/app/core/widgets/custom_textfield_filtro.dart';
import 'package:flutter_app/app/modules/empresa/models/empresa_model.dart';
import 'package:flutter_app/app/modules/endereco/models/endereco_model.dart';
import 'package:provider/provider.dart';
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
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      controller = Provider.of<EmpresasController>(context, listen: false);
      futureLoad = controller.loadEmpresas(); // Agora armazenando
      _initialized = true;
    }
  }

  @override
  void dispose() {
    controller.searchController
        .dispose(); // cuidado: só chame dispose se você criou!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: futureLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar: ${snapshot.error}'));
        } else {
          return Consumer<EmpresasController>(
            builder: (context, controller, child) {
              return _buildContent(controller);
            },
          );
        }
      },
    );
  }

  Widget _buildContent(EmpresasController controller) {
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
            padding: const EdgeInsets.only(bottom: 16),
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
                          endereco: EnderecoModel(),
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
          CustomTextTabelaTexto(text: empresa.endereco?.cidade?.cidade ?? ''),
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
