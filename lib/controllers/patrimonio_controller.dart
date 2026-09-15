
import 'package:get/get.dart';

import '../models/patrimonio.dart';
import '../services/patrimonio_service.dart';

class PatrimonioController extends GetxController {
  final PatrimonioService service = PatrimonioService();

  final listaPatrimonios = <Patrimonio>[].obs;

  final carregando = false.obs;

  final textoPesquisa = ''.obs;

  @override
  void onInit() {
    super.onInit();
    listar();
  }

  Future<void> listar() async {
    try {
      carregando.value = true;

      final lista = await service.listarPatrimonios(
        pesquisa: textoPesquisa.value,
      );

      listaPatrimonios.value = lista;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os patrimônios',
      );
    } finally {
      carregando.value = false;
    }
  }

  void pesquisar(String texto) {
    textoPesquisa.value = texto;
    listar();
  }

  Future<void> cadastrar(Patrimonio patrimonio) async {
    try {
      carregando.value = true;

      await service.cadastrar(patrimonio);

      Get.back();

      Get.snackbar(
        'Sucesso',
        'Patrimônio cadastrado',
      );

      listar();
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível cadastrar',
      );
    } finally {
      carregando.value = false;
    }
  }

  Future<void> editar(Patrimonio patrimonio) async {
    try {
      carregando.value = true;

      await service.editar(patrimonio);

      Get.back();

      Get.snackbar(
        'Sucesso',
        'Patrimônio atualizado',
      );

      listar();
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível editar',
      );
    } finally {
      carregando.value = false;
    }
  }

  Future<void> excluir(int id) async {
    try {
      carregando.value = true;

      await service.excluir(id);

      Get.snackbar(
        'Sucesso',
        'Patrimônio excluído',
      );

      listar();
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível excluir',
      );
    } finally {
      carregando.value = false;
    }
  }
}