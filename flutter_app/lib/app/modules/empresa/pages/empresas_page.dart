import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/widgets/custom_container_white.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_titulo.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_cabecalho.dart';
import 'package:flutter_app/app/core/widgets/custom_text_tabela_texto.dart';

class EmpresasPage extends StatefulWidget {
  const EmpresasPage({super.key});

  @override
  State<EmpresasPage> createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  @override
  Widget build(BuildContext context) {
    return CustomContainerWhite(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título (equivalente ao <h1 class="m-0">DataTables</h1>)
          const CustomTextTabelaTitulo(text: 'Empresas'),
          const SizedBox(height: 20),
          // Tabela
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: CustomTextTabelaCabecalho(text: 'Razão Social'),
                ),
                DataColumn(label: CustomTextTabelaCabecalho(text: 'Fantasia')),
                DataColumn(label: CustomTextTabelaCabecalho(text: 'CNPJ')),
                DataColumn(label: CustomTextTabelaCabecalho(text: 'Cidade')),
              ],
              rows: [
                _buildRow(
                  'Salles Vistorias Automotivas Ltda',
                  'Salles Vistorias',
                  '60.808.249/0001-50',
                  'Santa Cruz do Rio Pardo/SP',
                ),
                _buildRow('Garrett Winters', 'Accountant', 'Tokyo', '63'),
                _buildRow(
                  'Ashton Cox',
                  'Junior Technical Author',
                  'San Francisco',
                  '66',
                ),
                _buildRow(
                  'Cedric Kelly',
                  'Senior Javascript Developer',
                  'Edinburgh',
                  '22',
                ),
                _buildRow('Airi Satou', 'Accountant', 'Tokyo', '33'),
                _buildRow(
                  'Brielle Williamson',
                  'Integration Specialist',
                  'New York',
                  '61',
                ),
                _buildRow(
                  'Herrod Chandler',
                  'Sales Assistant',
                  'San Francisco',
                  '59',
                ),
                _buildRow(
                  'Rhona Davidson',
                  'Integration Specialist',
                  'Tokyo',
                  '55',
                ),
                _buildRow(
                  'Colleen Hurst',
                  'Javascript Developer',
                  'San Francisco',
                  '39',
                ),
                _buildRow(
                  'Sonya Frost',
                  'Software Engineer',
                  'Edinburgh',
                  '23',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String name, String position, String office, String age) {
    return DataRow(
      cells: [
        DataCell(CustomTextTabelaTexto(text: name)),
        DataCell(CustomTextTabelaTexto(text: position)),
        DataCell(CustomTextTabelaTexto(text: office)),
        DataCell(CustomTextTabelaTexto(text: age)),
      ],
    );
  }
}
