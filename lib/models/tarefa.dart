class Tarefa {
  String id;
  String titulo;
  String descricao;
  DateTime dataVencimento;
  String prioridade;
  bool concluida;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataVencimento,
    required this.prioridade,
    required this.concluida,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataVencimento': dataVencimento.toIso8601String(),
      'prioridade': prioridade,
      'concluida': concluida,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      dataVencimento: DateTime.parse(map['dataVencimento']),
      prioridade: map['prioridade'],
      concluida: map['concluida'] ?? false,
    );
  }
}
