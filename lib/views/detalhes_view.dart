import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patrimonio_controller.dart';
import '../models/patrimonio_model.dart';
import '../services/patrimonio_service.dart';
import 'formulario_view.dart';

class DetalhesView extends StatefulWidget {

  final int id;

  const DetalhesView({
    super.key,
    required this.id,
  });

  @override
  State<DetalhesView> createState() =>
      _DetalhesViewState();
}

class _DetalhesViewState
    extends State<DetalhesView> {

  final PatrimonioService service =
      PatrimonioService();

  PatrimonioModel? patrimonio;

  bool carregando = true;

  @override
  void initState() {

    super.initState();

    carregar();

  }

  Future<void> carregar() async {

    try {

      final resultado =
          await service.buscarPorId(widget.id);

      setState(() {

        patrimonio = resultado;

        carregando = false;

      });

    } catch (e) {

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
        title: const Text(
          'Detalhes do patrimônio',
        ),
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

              : Padding(

                  padding:
                      const EdgeInsets.all(20),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Icon(
                        Icons.inventory_2,
                        size: 80,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      _campo(
                        'ID',
                        '${patrimonio!.id}',
                      ),

                      _campo(
                        'Número do inventário',
                        patrimonio!.numeroInventario,
                      ),

                      _campo(
                        'Descrição',
                        patrimonio!.descricao,
                      ),

                      _campo(
                        'Local',
                        patrimonio!.local,
                      ),

                      _campo(
                        'Responsável',
                        patrimonio!.responsavel,
                      ),

                      const Spacer(),

                      // ============================
                      // BOTÕES
                      // ============================

                      SizedBox(

                        width: double.infinity,

                        child: ElevatedButton.icon(

                          onPressed: () async {

                            final resultado =
                                await Get.to(
                              () => FormularioView(
                                patrimonio:
                                    patrimonio,
                              ),
                            );

                            if (resultado == true) {

                              carregar();

                            }
                          },

                          icon: const Icon(
                            Icons.edit,
                          ),

                          label: const Text(
                            'Editar patrimônio',
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(

                        width: double.infinity,

                        child: OutlinedButton.icon(

                          style:
                              OutlinedButton.styleFrom(
                            foregroundColor:
                                Colors.red,
                          ),

                          onPressed: () {

                            confirmarExclusao();

                          },

                          icon: const Icon(
                            Icons.delete,
                          ),

                          label: const Text(
                            'Excluir patrimônio',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _campo(
    String titulo,
    String valor,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(bottom: 18),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            titulo,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void confirmarExclusao() {

    Get.dialog(

      AlertDialog(

        title: const Text(
          'Excluir patrimônio?',
        ),

        content: const Text(
          'Tem certeza que deseja excluir '
          'este patrimônio? Essa ação não pode '
          'ser desfeita.',
        ),

        actions: [

          TextButton(

            onPressed: () {
              Get.back();
            },

            child: const Text(
              'Cancelar',
            ),
          ),

          ElevatedButton(

            style:
                ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),

            onPressed: () async {

              Get.back();

              final controller =
                  Get.find<PatrimonioController>();

              await controller.excluir(
                widget.id,
              );

              Get.back();

            },

            child: const Text(
              'Excluir',
            ),
          ),
        ],
      ),
    );
  }
}