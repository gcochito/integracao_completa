import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patrimonio_controller.dart';
import '../models/patrimonio_model.dart';

class FormularioView extends StatefulWidget {

  final PatrimonioModel? patrimonio;

  const FormularioView({
    super.key,
    this.patrimonio,
  });

  @override
  State<FormularioView> createState() =>
      _FormularioViewState();
}

class _FormularioViewState
    extends State<FormularioView> {

  final formKey = GlobalKey<FormState>();

  final numeroController =
      TextEditingController();

  final descricaoController =
      TextEditingController();

  final localController =
      TextEditingController();

  final responsavelController =
      TextEditingController();

  final PatrimonioController controller =
      Get.find<PatrimonioController>();

  bool salvando = false;

  bool get editando =>
      widget.patrimonio != null;

  @override
  void initState() {

    super.initState();

    if (editando) {

      numeroController.text =
          widget.patrimonio!.numeroInventario;

      descricaoController.text =
          widget.patrimonio!.descricao;

      localController.text =
          widget.patrimonio!.local;

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
              : 'Novo patrimônio',
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                editando
                    ? 'Alterar patrimônio'
                    : 'Cadastrar patrimônio',

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                editando
                    ? 'Altere os dados do patrimônio.'
                    : 'Preencha os dados para cadastrar '
                      'um novo patrimônio.',
              ),

              const SizedBox(
                height: 30,
              ),

              // ============================
              // INVENTÁRIO
              // ============================

              TextFormField(

                controller:
                    numeroController,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Número do inventário',
                  prefixIcon:
                      Icon(Icons.numbers),
                  border:
                      OutlineInputBorder(),
                ),

                validator: (valor) {

                  if (valor == null ||
                      valor.trim().isEmpty) {

                    return 'Informe o número do inventário';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 18,
              ),

              // ============================
              // DESCRIÇÃO
              // ============================

              TextFormField(

                controller:
                    descricaoController,

                maxLines: 3,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Descrição',
                  prefixIcon:
                      Icon(Icons.description),
                  border:
                      OutlineInputBorder(),
                ),

                validator: (valor) {

                  if (valor == null ||
                      valor.trim().isEmpty) {

                    return 'Informe a descrição';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 18,
              ),

              // ============================
              // LOCAL
              // ============================

              TextFormField(

                controller:
                    localController,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Local',
                  prefixIcon:
                      Icon(Icons.location_on),
                  border:
                      OutlineInputBorder(),
                ),

                validator: (valor) {

                  if (valor == null ||
                      valor.trim().isEmpty) {

                    return 'Informe o local';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 18,
              ),

              // ============================
              // RESPONSÁVEL
              // ============================

              TextFormField(

                controller:
                    responsavelController,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Responsável',
                  prefixIcon:
                      Icon(Icons.person),
                  border:
                      OutlineInputBorder(),
                ),

                validator: (valor) {

                  if (valor == null ||
                      valor.trim().isEmpty) {

                    return 'Informe o responsável';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 30,
              ),

              // ============================
              // BOTÃO
              // ============================

              SizedBox(

                width: double.infinity,

                height: 52,

                child: ElevatedButton.icon(

                  onPressed:
                      salvando
                          ? null
                          : salvar,

                  icon: salvando

                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )

                      : Icon(
                          editando
                              ? Icons.save
                              : Icons.add,
                        ),

                  label: Text(
                    salvando
                        ? 'Salvando...'
                        : editando
                            ? 'Salvar alterações'
                            : 'Cadastrar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================
  // SALVAR
  // ============================

  Future<void> salvar() async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      salvando = true;
    });

    final patrimonio =
        PatrimonioModel(

      id: widget.patrimonio?.id,

      numeroInventario:
          numeroController.text.trim(),

      descricao:
          descricaoController.text.trim(),

      local:
          localController.text.trim(),

      responsavel:
          responsavelController.text.trim(),
    );

    bool sucesso;

    if (editando) {

      sucesso =
          await controller.editar(
        patrimonio,
      );

    } else {

      sucesso =
          await controller.cadastrar(
        patrimonio,
      );
    }

    setState(() {
      salvando = false;
    });

    if (sucesso) {

      Get.back(
        result: true,
      );
    }
  }
}