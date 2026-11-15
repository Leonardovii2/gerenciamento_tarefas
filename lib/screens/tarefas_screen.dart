import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../services/firebase_service.dart';
import 'cadastro_tarefa_screen.dart';
import 'detalhes_tarefa_screen.dart';

class TarefasScreen extends StatelessWidget {
  const TarefasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final modoEscuro = tema.brightness == Brightness.dark;

    const verdeEscuro = Color(0xFF047857);
    const verdePrincipal = Color(0xFF10B981);
    const verdeClaro = Color(0xFF34D399);

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        backgroundColor: modoEscuro ? const Color(0xFF065F46) : verdeEscuro,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: modoEscuro ? verdeClaro : verdeEscuro,
        foregroundColor: modoEscuro ? const Color(0xFF064E3B) : Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CadastroTarefaScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: StreamBuilder<List<Tarefa>>(
        stream: firebaseService.listarTarefas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: cores.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar tarefas.',
                style: TextStyle(color: cores.onSurface),
              ),
            );
          }

          final tarefas = snapshot.data ?? [];

          if (tarefas.isEmpty) {
            return Center(
              child: Text(
                'Nenhuma tarefa cadastrada.',
                style: TextStyle(
                  fontSize: 16,
                  color: cores.onSurface.withOpacity(0.70),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = tarefas[index];

              return Card(
                color: tema.cardColor,
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesTarefaScreen(tarefa: tarefa),
                      ),
                    );
                  },

                  leading: Checkbox(
                    activeColor: verdePrincipal,
                    value: tarefa.concluida,
                    onChanged: (valor) async {
                      await firebaseService.alterarStatus(
                        tarefa.id,
                        valor ?? false,
                      );
                    },
                  ),

                  title: Text(
                    tarefa.titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cores.onSurface,
                      decoration: tarefa.concluida
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

                  subtitle: Text(
                    '${tarefa.descricao}\n'
                    'Vencimento: ${tarefa.dataVencimento.day}/'
                    '${tarefa.dataVencimento.month}/'
                    '${tarefa.dataVencimento.year}',
                    style: TextStyle(color: cores.onSurface.withOpacity(0.70)),
                  ),

                  isThreeLine: true,

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tarefa.prioridade,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: modoEscuro
                              ? const Color(0xFF6EE7B7)
                              : verdeEscuro,
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.edit, color: verdePrincipal),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CadastroTarefaScreen(tarefa: tarefa),
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirmar = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: cores.surface,
                              title: Text(
                                'Excluir tarefa',
                                style: TextStyle(color: cores.onSurface),
                              ),
                              content: Text(
                                'Deseja realmente excluir esta tarefa?',
                                style: TextStyle(
                                  color: cores.onSurface.withOpacity(0.80),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: cores.primary),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text(
                                    'Excluir',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirmar == true) {
                            await firebaseService.excluirTarefa(tarefa.id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
