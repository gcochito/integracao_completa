
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patrimonio_controller.dart';
import '../models/patrimonio.dart';
import 'cadastro_patrimonio_page.dart';
import 'detalhes_patrimonio_page.dart';

class PatrimonioPage extends StatelessWidget {
  PatrimonioPage({super.key});

  final PatrimonioController controller =
      Get.find<PatrimonioController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrimônios SENAI'),
        backgroundColor: const Color(0xFF205988),
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(
            () => CadastroPatrimonioPage(),
          );
        },
        backgroundColor: const Color(0xFF205988),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Cadastrar'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: controller.pesquisar,
              decoration: InputDecoration(
                hintText: 'Pesquisar patrimônio...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.pesquisar('');
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.carregando.value &&
                  controller.listaPatrimonios.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.listaPatrimonios.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum patrimônio encontrado.',
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.listar,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    100,
                  ),
                  itemCount:
                      controller.listaPatrimonios.length,
                  itemBuilder: (context, index) {
                    final patrimonio =
                        controller.listaPatrimonios[index];

                    return Card(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.inventory_2,
                                  color: Color(0xFF205988),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    patrimonio.descricao,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Inventário: '
                              '${patrimonio.numeroInventario}',
                            ),

                            Text(
                              'Local: ${patrimonio.local}',
                            ),

                            Text(
                              'Responsável: '
                              '${patrimonio.responsavel}',
                            ),

                            const Divider(),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    if (patrimonio.id != null) {
                                      Get.to(
                                        () =>
                                            DetalhesPatrimonioPage(
                                          id: patrimonio.id!,
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.visibility,
                                  ),
                                  label: const Text('Detalhes'),
                                ),

                                IconButton(
                                  tooltip: 'Editar',
                                  onPressed: () {
                                    Get.to(
                                      () =>
                                          CadastroPatrimonioPage(
                                        patrimonio: patrimonio,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),

                                IconButton(
                                  tooltip: 'Excluir',
                                  onPressed: () {
                                    _confirmarExclusao(
                                      context,
                                      patrimonio,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _confirmarExclusao(
    BuildContext context,
    Patrimonio patrimonio,
  ) {
    if (patrimonio.id == null) {
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('Excluir patrimônio?'),
        content: Text(
          'Deseja realmente excluir o patrimônio '
          '${patrimonio.numeroInventario}?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancelar'),
          ),

          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.excluir(patrimonio.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}