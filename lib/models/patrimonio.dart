
class Patrimonio {
  final int? id;
  final String numeroInventario;
  final String descricao;
  final String local;
  final String responsavel;

  Patrimonio({
    this.id,
    required this.numeroInventario,
    required this.descricao,
    required this.local,
    required this.responsavel,
  });

  factory Patrimonio.fromJson(Map<String, dynamic> json) {
    return Patrimonio(
      id: json['id'],
      numeroInventario: json['numero_inventario'] ?? '',
      descricao: json['descricao'] ?? '',
      local: json['local'] ?? '',
      responsavel: json['responsavel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_inventario': numeroInventario,
      'descricao': descricao,
      'local': local,
      'responsavel': responsavel,
    };
  }
}