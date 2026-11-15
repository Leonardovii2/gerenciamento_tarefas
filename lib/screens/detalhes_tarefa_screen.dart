import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class DetalhesTarefaScreen extends StatelessWidget {
  final Tarefa tarefa;

  const DetalhesTarefaScreen({super.key, required this.tarefa});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Detalhes da Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tarefa.titulo,
              style: tema.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: cores.onSurface,
              ),
            ),

            const SizedBox(height: 20),

            _tituloSecao(context, 'Descrição'),
            const SizedBox(height: 5),
            Text(
              tarefa.descricao.isEmpty
                  ? 'Nenhuma descrição informada.'
                  : tarefa.descricao,
              style: tema.textTheme.bodyLarge?.copyWith(color: cores.onSurface),
            ),

            const SizedBox(height: 20),

            _tituloSecao(context, 'Data de vencimento'),
            const SizedBox(height: 5),
            Text(
              '${tarefa.dataVencimento.day}/'
              '${tarefa.dataVencimento.month}/'
              '${tarefa.dataVencimento.year}',
              style: tema.textTheme.bodyLarge?.copyWith(color: cores.onSurface),
            ),

            const SizedBox(height: 20),

            _tituloSecao(context, 'Prioridade'),
            const SizedBox(height: 5),
            Text(
              tarefa.prioridade,
              style: tema.textTheme.bodyLarge?.copyWith(color: cores.onSurface),
            ),

            const SizedBox(height: 20),

            _tituloSecao(context, 'Situação'),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  tarefa.concluida ? Icons.check_circle : Icons.pending_actions,
                  color: tarefa.concluida ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  tarefa.concluida ? 'Concluída' : 'Pendente',
                  style: tema.textTheme.bodyLarge?.copyWith(
                    color: cores.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tituloSecao(BuildContext context, String texto) {
    return Text(
      texto,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
