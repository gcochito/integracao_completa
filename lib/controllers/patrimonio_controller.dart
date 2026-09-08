import 'package:get/get.dart';

import '../models/patrimonio_model.dart';
import '../services/patrimonio_service.dart';

class PatrimonioController extends GetxController {

  final PatrimonioService service = PatrimonioService();

  // Lista de patrimônios
  final patrimonios = <PatrimonioModel>[].obs;

  // Indicador de carregamento
  final carregando = false.obs;

  // Mensagem de erro
  final erro = ''.obs;

  @override
  void onInit() {
    super.onInit();

    carregarPatrimonios();
  }

  // ============================
  // LISTAR
  // ============================

  Future<void> carregarPatrimonios() async {

    try {

      carregando.value = true;
      erro.value = '';

      final resultado =
          await service.listarPatrimonios();

      patrimonios.assignAll(resultado);

    } catch (e) {

      erro.value = e.toString();

      Get.snackbar(
        'Erro',
        'Não foi possível carregar os patrimônios',
      );

    } finally {

      carregando.value = false;

    }
  }

  // ============================
  // PESQUISAR
  // ============================

  Future<void> pesquisar(String termo) async {

    if (termo.isEmpty) {

      carregarPatrimonios();

      return;
    }

    try {

      carregando.value = true;
      erro.value = '';

      final resultado =
          await service.pesquisarPatrimonios(termo);

      patrimonios.assignAll(resultado);

    } catch (e) {

      erro.value = e.toString();

      Get.snackbar(
        'Erro',
        'Não foi possível realizar a pesquisa',
      );

    } finally {

      carregando.value = false;

    }
  }

  // ============================
  // CADASTRAR
  // ============================

  Future<bool> cadastrar(
      PatrimonioModel patrimonio) async {

    try {

      carregando.value = true;

      await service.cadastrar(patrimonio);

      Get.snackbar(
        'Sucesso',
        'Patrimônio cadastrado!',
      );

      await carregarPatrimonios();

      return true;

    } catch (e) {

      Get.snackbar(
        'Erro',
        'Não foi possível cadastrar',
      );

      return false;

    } finally {

      carregando.value = false;

    }
  }

  // ============================
  // EDITAR
  // ============================

  Future<bool> editar(
      PatrimonioModel patrimonio) async {

    try {

      carregando.value = true;

      await service.editar(patrimonio);

      Get.snackbar(
        'Sucesso',
        'Patrimônio atualizado!',
      );

      await carregarPatrimonios();

      return true;

    } catch (e) {

      Get.snackbar(
        'Erro',
        'Não foi possível atualizar',
      );

      return false;

    } finally {

      carregando.value = false;

    }
  }

  // ============================
  // EXCLUIR
  // ============================

  Future<void> excluir(int id) async {

    try {

      carregando.value = true;

      await service.excluir(id);

      Get.snackbar(
        'Sucesso',
        'Patrimônio excluído!',
      );

      await carregarPatrimonios();

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