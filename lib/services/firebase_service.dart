import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/tarefa.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  String get _uid {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  DatabaseReference get _tarefasRef {
    return _database.child('tarefas').child(_uid);
  }

  // Cadastrar tarefa
  Future<void> cadastrarTarefa(Tarefa tarefa) async {
    await _tarefasRef.child(tarefa.id).set(tarefa.toMap());
  }

  // Listar tarefas em tempo real
  Stream<List<Tarefa>> listarTarefas() {
    return _tarefasRef.onValue.map((event) {
      final dados = event.snapshot.value;

      if (dados == null) {
        return [];
      }

      final mapa = Map<String, dynamic>.from(dados as Map);

      return mapa.values.map((item) {
        return Tarefa.fromMap(Map<String, dynamic>.from(item));
      }).toList();
    });
  }

  // Editar tarefa
  Future<void> editarTarefa(Tarefa tarefa) async {
    await _tarefasRef.child(tarefa.id).update(tarefa.toMap());
  }

  // Excluir tarefa
  Future<void> excluirTarefa(String id) async {
    await _tarefasRef.child(id).remove();
  }

  // Alterar status da tarefa
  Future<void> alterarStatus(String id, bool concluida) async {
    await _tarefasRef.child(id).update({'concluida': concluida});
  }
}
