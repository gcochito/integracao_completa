
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/patrimonio.dart';
import '../services/patrimonio_service.dart';
import 'cadastro_patrimonio_page.dart';

class DetalhesPatrimonioPage extends StatefulWidget {
  final int id;

  const DetalhesPatrimonioPage({
    super.key,
    required this.id,
  });

  @override
  State<DetalhesPatrimonioPage> createState() =>
      _DetalhesPatrimonioPageState();
}

class _DetalhesPatrimonioPageState
    extends State<DetalhesPatrimonioPage> {
  final PatrimonioService service = PatrimonioService();

  Patrimonio? patrimonio;

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    try {
      final resultado = await service.buscarPorId(widget.id);

      if (!mounted) {
        return;
      }

      setState(() {
        patrimonio = resultado;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        carregando = false;
      });

      Get.snackbar(
        'Erro',
        'Não foi possível carregar os dados',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do patrimônio'),
        backgroundColor: const Color(0xFF205988),
        foregroundColor: Colors.white,
      ),

      body: carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : patrimonio == null
              ? const Center(
                  child: Text(
                    'Patrimônio não encontrado',
                  ),
                )
              : _conteudo(),
    );
  }

  Widget _conteudo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.inventory_2,
              size: 90,
              color: Color(0xFF205988),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              patrimonio!.descricao,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 28),

          _informacao(
            'ID',
            patrimonio!.id?.toString() ?? '-',
          ),

          _informacao(
            'Número do inventário',
            patrimonio!.numeroInventario,
          ),

          _informacao(
            'Descrição',
            patrimonio!.descricao,
          ),

          _informacao(
            'Local',
            patrimonio!.local,
          ),

          _informacao(
            'Responsável',
            patrimonio!.responsavel,
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await Get.to(
                  () => CadastroPatrimonioPage(
                    patrimonio: patrimonio,
                  ),
                );

                carregar();
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar patrimônio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF205988),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _informacao(String titulo, String valor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}