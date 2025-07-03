import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/widgets/custom_buttom.dart';
import 'package:flutter_app/app/modules/empresa/pages/empresa_page.dart';
import '../../../core/helpers/screen_helper.dart';
import '../../empresa/pages/empresas_page.dart';
import '../../empresa/models/empresa_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String opcaoSelecionada = 'Home';

  /// Guarda o hover de cada botão
  final Map<String, bool> hovering = {};

  EmpresaModel? empresaSelecionada;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenHelper.maximizarWindow();
    });

    // Inicializa os estados de hover
    for (var opcao in ['Home', 'Empresas', 'Clientes']) {
      hovering[opcao] = false;
    }
  }

  Widget _buildMenuButton(String opcao) {
    return CustomButton(
      label: opcao,
      isSelected: opcaoSelecionada == opcao,
      onTap: () {
        setState(() {
          opcaoSelecionada = opcao;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          Container(
            width: 200,
            decoration: const BoxDecoration(color: Colors.black87),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  color: Colors.amber,
                ),
                _buildMenuButton('Home'),
                _buildMenuButton('Empresas'),
                _buildMenuButton('Clientes'),
              ],
            ),
          ),

          // Conteúdo do painel direito
          Expanded(
            child: Container(color: Colors.white, child: _getConteudoWidget()),
          ),
        ],
      ),
    );
  }

  Widget _getConteudoWidget() {
    switch (opcaoSelecionada) {
      case 'Home':
        return const Center(
          child: Text('Você está na Home.', style: TextStyle(fontSize: 24)),
        );

      case 'Empresas':
        return EmpresasPage(
          onIncluirPressed: (empresa) {
            setState(() {
              empresaSelecionada = empresa;
              opcaoSelecionada = 'Empresa';
            });
          },
          onAlterarPressed: (empresa) {
            setState(() {
              empresaSelecionada = empresa;
              opcaoSelecionada = 'Empresa';
            });
          },
          onDesativarPressed: (empresa) {
            setState(() {
              // faça algo com a empresa se necessário
              empresaSelecionada = empresa;
              opcaoSelecionada = 'Empresas';
            });
          },
        );

      case 'Empresa':
        return EmpresaPage(
          empresa: empresaSelecionada,
          onCancelarPressed: () {
            setState(() {
              opcaoSelecionada = 'Empresas';
            });
          },
        );

      case 'Clientes':
        return const Center(
          child: Text('Lista de Clientes.', style: TextStyle(fontSize: 24)),
        );

      default:
        return const Center(
          child: Text('Selecione uma opção.', style: TextStyle(fontSize: 24)),
        );
    }
  }
}
