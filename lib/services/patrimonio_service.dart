import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/patrimonio_model.dart';

class PatrimonioService {

  final String baseUrl = 'http://localhost:8080';

  // ============================
  // LISTAR
  // ============================

  Future<List<PatrimonioModel>> listarPatrimonios() async {

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/patrimonios'),
    );

    if (response.statusCode == 200) {

      final dados = jsonDecode(response.body);

      return (dados as List)
          .map((item) => PatrimonioModel.fromJson(item))
          .toList();

    } else {

      throw Exception('Erro ao carregar patrimônios');

    }
  }

  // ============================
  // PESQUISAR
  // ============================

  Future<List<PatrimonioModel>> pesquisarPatrimonios(
      String termo) async {

    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/v1/patrimonios?q=${Uri.encodeComponent(termo)}',
      ),
    );

    if (response.statusCode == 200) {

      final dados = jsonDecode(response.body);

      return (dados as List)
          .map((item) => PatrimonioModel.fromJson(item))
          .toList();

    } else {

      throw Exception('Erro ao pesquisar patrimônios');

    }
  }

  // ============================
  // DETALHES
  // ============================

  Future<PatrimonioModel> buscarPorId(int id) async {

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/patrimonios/$id'),
    );

    if (response.statusCode == 200) {

      final dados = jsonDecode(response.body);

      return PatrimonioModel.fromJson(dados);

    } else {

      throw Exception('Erro ao buscar patrimônio');

    }
  }

  // ============================
  // CADASTRAR
  // ============================

  Future<void> cadastrar(PatrimonioModel patrimonio) async {

    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/patrimonios'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(patrimonio.toJson()),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception('Erro ao cadastrar patrimônio');

    }
  }

  // ============================
  // EDITAR
  // ============================

  Future<void> editar(PatrimonioModel patrimonio) async {

    final response = await http.put(
      Uri.parse(
        '$baseUrl/api/v1/patrimonios/${patrimonio.id}',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(patrimonio.toJson()),
    );

    if (response.statusCode != 200) {

      throw Exception('Erro ao editar patrimônio');

    }
  }

  // ============================
  // EXCLUIR
  // ============================

  Future<void> excluir(int id) async {

    final response = await http.delete(
      Uri.parse('$baseUrl/api/v1/patrimonios/$id'),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 204) {

      throw Exception('Erro ao excluir patrimônio');

    }
  }
}