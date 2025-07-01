import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/widgets/custom_buttom.dart';
import 'package:flutter_app/app/core/widgets/custom_container_white.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_titulo.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_cabecalho.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_texto.dart';
import 'package:flutter_app/app/core/widgets/custom_textfield_filtro.dart';

class EmpresasPage extends StatefulWidget {
  const EmpresasPage({super.key});

  @override
  State<EmpresasPage> createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  final TextEditingController _searchController = TextEditingController();

  // Lista original de dados
  late List<List<String>> allRows;

  // Lista que exibe na tabela
  late List<List<String>> filteredRows;

  @override
  void initState() {
    super.initState();

    allRows = [
      [
        'Salles Vistorias Automotivas Ltda',
        'Salles Vistorias',
        '60.808.249/0001-50',
        'Santa Cruz do Rio Pardo/SP',
      ],
      ['Garrett Winters', 'Accountant', 'Tokyo', '63'],
      ['Ashton Cox', 'Junior Technical Author', 'San Francisco', '66'],
      ['Cedric Kelly', 'Senior Javascript Developer', 'Edinburgh', '22'],
      ['Airi Satou', 'Accountant', 'Tokyo', '33'],
      ['Brielle Williamson', 'Integration Specialist', 'New York', '61'],
      ['Herrod Chandler', 'Sales Assistant', 'San Francisco', '59'],
      ['Rhona Davidson', 'Integration Specialist', 'Tokyo', '55'],
      ['Colleen Hurst', 'Javascript Developer', 'San Francisco', '39'],
      ['Sonya Frost', 'Software Engineer', 'Edinburgh', '23'],
      [
        'Salles Vistorias Automotivas Ltda',
        'Salles Vistorias',
        '60.808.249/0001-50',
        'Santa Cruz do Rio Pardo/SP',
      ],
      ['Garrett Winters', 'Accountant', 'Tokyo', '63'],
    ];

    filteredRows = List.from(allRows);

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String search = _searchController.text.toLowerCase();

    setState(() {
      filteredRows =
          allRows.where((row) {
            return row.any((cell) => cell.toLowerCase().contains(search));
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainerWhite(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextTabelaTitulo(text: 'Empresas'),
          const SizedBox(height: 10),

          // Campo de filtro
          Container(
            height: 100,
            width: 1200,
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 100,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextFieldFiltro(
                    label: 'Pesquisar',
                    controller: _searchController,
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
                      filteredRows.map((row) {
                        return _buildRow(row[0], row[1], row[2], row[3]);
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String name, String position, String office, String age) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(width: 250, child: CustomTextTabelaTexto(text: name)),
        ),
        DataCell(
          SizedBox(width: 150, child: CustomTextTabelaTexto(text: position)),
        ),
        DataCell(
          SizedBox(width: 150, child: CustomTextTabelaTexto(text: office)),
        ),
        DataCell(SizedBox(width: 210, child: CustomTextTabelaTexto(text: age))),
        DataCell(
          SizedBox(
            width: 100,
            child: Row(
              children: [
                CustomButton(
                  label: '',
                  isSelected: false,
                  icon: Icons.edit,
                  onTap: () => print('Editar $name'),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  label: '',
                  isSelected: false,
                  icon: Icons.delete,
                  onTap: () => print('Excluir $name'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
