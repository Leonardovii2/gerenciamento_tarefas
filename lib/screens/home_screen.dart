import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/firebase_service.dart';
import '../models/usuario.dart';
import 'tarefas_screen.dart';
import 'configuracoes_screen.dart';
import 'sobre_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  final Color verdePrincipal = const Color(0xFF10B981);
  final Color verdeEscuro = const Color(0xFF047857);

  @override
  Widget build(BuildContext context) {
    final Usuario? usuario = AuthService().usuarioAtual;

    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final modoEscuro = tema.brightness == Brightness.dark;

    final corMenu = modoEscuro
        ? const Color(0xFF065F46)
        : const Color(0xFF047857);

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          'Início',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: corMenu,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      drawer: Drawer(
        backgroundColor: cores.surface,
        surfaceTintColor: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: corMenu),
              accountName: Text(
                usuario?.nome ?? 'Usuário',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                usuario?.email ?? '',
                style: const TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 35, color: corMenu),
              ),
            ),

            _itemMenu(
              context,
              Icons.home,
              'Início',
              () => Navigator.pop(context),
            ),

            _itemMenu(context, Icons.task, 'Minhas Tarefas', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TarefasScreen()),
              );
            }),

            _itemMenu(context, Icons.settings, 'Configurações', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConfiguracoesScreen()),
              );
            }),

            _itemMenu(context, Icons.info, 'Sobre o aplicativo', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SobreScreen()),
              );
            }),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text('Sair', style: TextStyle(color: cores.onSurface)),
              onTap: () async {
                Navigator.pop(context);
                await AuthService().logout();
              },
            ),
          ],
        ),
      ),

      body: StreamBuilder(
        stream: _firebaseService.listarTarefas(),
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

          final total = tarefas.length;

          final pendentes = tarefas.where((tarefa) {
            return !tarefa.concluida;
          }).length;

          final concluidas = tarefas.where((tarefa) {
            return tarefa.concluida;
          }).length;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, ${usuario?.nome ?? 'Usuário'}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cores.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Confira o resumo das suas tarefas.',
                  style: TextStyle(
                    fontSize: 15,
                    color: cores.onSurface.withOpacity(0.70),
                  ),
                ),

                const SizedBox(height: 25),

                _cardResumo(
                  context,
                  Icons.assignment,
                  'Total de tarefas',
                  total,
                  const Color(0xFF10B981),
                ),

                _cardResumo(
                  context,
                  Icons.pending_actions,
                  'Tarefas pendentes',
                  pendentes,
                  const Color(0xFFF59E0B),
                ),

                _cardResumo(
                  context,
                  Icons.check_circle,
                  'Tarefas concluídas',
                  concluidas,
                  const Color(0xFF059669),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _itemMenu(
    BuildContext context,
    IconData icone,
    String titulo,
    VoidCallback onTap,
  ) {
    final modoEscuro = Theme.of(context).brightness == Brightness.dark;

    final corIcone = modoEscuro
        ? const Color(0xFF34D399)
        : const Color(0xFF047857);

    final cores = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icone, color: corIcone),
      iconColor: corIcone,
      title: Text(
        titulo,
        style: TextStyle(color: cores.onSurface, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  Widget _cardResumo(
    BuildContext context,
    IconData icone,
    String titulo,
    int quantidade,
    Color cor,
  ) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;

    return Card(
      color: tema.cardColor,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),

        leading: CircleAvatar(
          backgroundColor: cor.withOpacity(0.15),
          child: Icon(icone, color: cor),
        ),

        title: Text(
          titulo,
          style: TextStyle(fontWeight: FontWeight.w500, color: cores.onSurface),
        ),

        trailing: Text(
          '$quantidade',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: cor,
          ),
        ),
      ),
    );
  }
}
