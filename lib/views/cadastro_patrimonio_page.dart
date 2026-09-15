
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patrimonio_controller.dart';
import '../models/patrimonio.dart';

class CadastroPatrimonioPage extends StatefulWidget {
  final Patrimonio? patrimonio;

  const CadastroPatrimonioPage({
    super.key,
    this.patrimonio,
  });

  @override
  State<CadastroPatrimonioPage> createState() =>
      _CadastroPatrimonioPageState();
}

class _CadastroPatrimonioPageState
    extends State<CadastroPatrimonioPage> {
  final formKey = GlobalKey<FormState>();

  final numeroController = TextEditingController();
  final descricaoController = TextEditingController();
  final localController = TextEditingController();
  final responsavelController = TextEditingController();

  final PatrimonioController controller =
      Get.find<PatrimonioController>();

  bool get editando => widget.patrimonio != null;

  @override
  void initState() {
    super.initState();

    if (widget.patrimonio != null) {
      numeroController.text =
          widget.patrimonio!.numeroInventario;

      descricaoController.text =
          widget.patrimonio!.descricao;

      localController.text = widget.patrimonio!.local;

      responsavelController.text =
          widget.patrimonio!.responsavel;
    }
  }

  @override
  void dispose() {
    numeroController.dispose();
    descricaoController.dispose();
    localController.dispose();
    responsavelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando
              ? 'Editar patrimônio'
              : 'Cadastrar patrimônio',
        ),
        backgroundColor: const Color(0xFF205988),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                editando
                    ? 'Alterar patrimônio'
                    : 'Novo patrimônio',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              _campo(
                controller: numeroController,
                label: 'Número do inventário',
                icone: Icons.numbers,
              ),

              const SizedBox(height: 16),

              _campo(
                controller: descricaoController,
                label: 'Descrição',
                icone: Icons.inventory_2,
              ),

              const SizedBox(height: 16),

              _campo(
                controller: localController,
                label: 'Local',
                icone: Icons.location_on,
              ),

              const SizedBox(height: 16),

              _campo(
                controller: responsavelController,
                label: 'Responsável',
                icone: Icons.person,
              ),

              const SizedBox(height: 28),

              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.carregando.value
                        ? null
                        : salvar,
                    icon: const Icon(Icons.save),
                    label: Text(
                      editando
                          ? 'Salvar alterações'
                          : 'Salvar patrimônio',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF205988),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo({
    required TextEditingController controller,
    required String label,
    required IconData icone,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icone),
        border: const OutlineInputBorder(),
      ),
      validator: (valor) {
        if (valor == null || valor.trim().isEmpty) {
          return 'Preencha este campo';
        }

        return null;
      },
    );
  }

  void salvar() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final patrimonio = Patrimonio(
      id: widget.patrimonio?.id,
      numeroInventario: numeroController.text.trim(),
      descricao: descricaoController.text.trim(),
      local: localController.text.trim(),
      responsavel: responsavelController.text.trim(),
    );

    if (editando) {
      controller.editar(patrimonio);
    } else {
      controller.cadastrar(patrimonio);
    }
  }
}