
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/patrimonio.dart';

class PatrimonioService {
  // Para Chrome ou Windows, use localhost.
  // Para emulador Android, normalmente use 10.0.2.2.
  final String url = 'http://localhost:8080';

  Future<List<Patrimonio>> listarPatrimonios({
    String pesquisa = '',
  }) async {
    String endereco = '$url/api/v1/patrimonios';

    if (pesquisa.isNotEmpty) {
      endereco =
          '$endereco?q=${Uri.encodeQueryComponent(pesquisa)}';
    }

    final resposta = await http.get(Uri.parse(endereco));

    if (resposta.statusCode == 200) {
      final dados = jsonDecode(resposta.body);

      List lista = dados;

      return lista.map((item) {
        return Patrimonio.fromJson(item);
      }).toList();
    }

    throw Exception('Erro ao buscar patrimônios');
  }

  Future<Patrimonio> buscarPorId(int id) async {
    final resposta = await http.get(
      Uri.parse('$url/api/v1/patrimonios/$id'),
    );

    if (resposta.statusCode == 200) {
      return Patrimonio.fromJson(
        jsonDecode(resposta.body),
      );
    }

    throw Exception('Erro ao buscar patrimônio');
  }

  Future<void> cadastrar(Patrimonio patrimonio) async {
    final resposta = await http.post(
      Uri.parse('$url/api/v1/patrimonios'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(patrimonio.toJson()),
    );

    if (resposta.statusCode != 200 &&
        resposta.statusCode != 201) {
      throw Exception('Erro ao cadastrar patrimônio');
    }
  }

  Future<void> editar(Patrimonio patrimonio) async {
    final resposta = await http.put(
      Uri.parse('$url/api/v1/patrimonios/${patrimonio.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(patrimonio.toJson()),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao editar patrimônio');
    }
  }

  Future<void> excluir(int id) async {
    final resposta = await http.delete(
      Uri.parse('$url/api/v1/patrimonios/$id'),
    );

    if (resposta.statusCode != 200 &&
        resposta.statusCode != 204) {
      throw Exception('Erro ao excluir patrimônio');
    }
  }
}