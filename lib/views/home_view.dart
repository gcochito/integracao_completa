import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patrimonio_controller.dart';
import 'detalhes_view.dart';
import 'formulario_view.dart';

class HomeView extends StatelessWidget {

  HomeView({super.key});

  final PatrimonioController controller =
      Get.find<PatrimonioController>();

  final TextEditingController pesquisaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Patrimônios SENAI',
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // ============================
          // CAMPO DE PESQUISA
          // ============================

          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(

              controller: pesquisaController,

              decoration: InputDecoration(

                labelText: 'Pesquisar patrimônio',

                hintText: 'Digite uma descrição, local...',

                prefixIcon: const Icon(
                  Icons.search,
                ),

                suffixIcon: IconButton(

                  icon: const Icon(
                    Icons.clear,
                  ),

                  onPressed: () {

                    pesquisaController.clear();

                    controller.carregarPatrimonios();

                  },
                ),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              onChanged: (valor) {

                controller.pesquisar(valor);

              },
            ),
          ),

          // ============================
          // LISTA
          // ============================

          Expanded(

            child: Obx(() {

              if (controller.carregando.value &&
                  controller.patrimonios.isEmpty) {

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.erro.value.isNotEmpty &&
                  controller.patrimonios.isEmpty) {

                return Center(

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.error_outline,
                        size: 60,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      const Text(
                        'Erro ao carregar patrimônios',
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      ElevatedButton(

                        onPressed: () {
                          controller.carregarPatrimonios();
                        },

                        child: const Text(
                          'Tentar novamente',
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (controller.patrimonios.isEmpty) {

                return const Center(

                  child: Text(
                    'Nenhum patrimônio encontrado',
                  ),
                );
              }

              return RefreshIndicator(

                onRefresh:
                    controller.carregarPatrimonios,

                child: ListView.builder(

                  padding:
                      const EdgeInsets.all(16),

                  itemCount:
                      controller.patrimonios.length,

                  itemBuilder:
                      (context, index) {

                    final patrimonio =
                        controller.patrimonios[index];

                    return Card(

                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: ListTile(

                        leading: CircleAvatar(

                          child: Text(
                            '${patrimonio.id ?? ''}',
                          ),
                        ),

                        title: Text(
                          patrimonio.descricao,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        subtitle: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              'Inventário: '
                              '${patrimonio.numeroInventario}',
                            ),

                            Text(
                              'Local: '
                              '${patrimonio.local}',
                            ),

                            Text(
                              'Responsável: '
                              '${patrimonio.responsavel}',
                            ),
                          ],
                        ),

                        trailing:
                            const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),

                        onTap: () {

                          Get.to(
                            () => DetalhesView(
                              id: patrimonio.id!,
                            ),
                          );

                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),

      // ============================
      // BOTÃO CADASTRAR
      // ============================

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {

          Get.to(
            () => const FormularioView(),
          );

        },

        icon: const Icon(
          Icons.add,
        ),

        label: const Text(
          'Cadastrar',
        ),
      ),
    );
  }
}