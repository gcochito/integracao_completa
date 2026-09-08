class PatrimonioModel {
  int? id;
  String numeroInventario;
  String descricao;
  String local;
  String responsavel;

  PatrimonioModel({
    this.id,
    required this.numeroInventario,
    required this.descricao,
    required this.local,
    required this.responsavel,
  });

  factory PatrimonioModel.fromJson(Map<String, dynamic> json) {
    return PatrimonioModel(
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