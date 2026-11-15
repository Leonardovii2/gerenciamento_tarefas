import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final temaEscuro = tema.brightness == Brightness.dark;

    const verdeEscuro = Color(0xFF047857);
    const verdeBarraEscura = Color(0xFF065F46);
    const verdeClaro = Color(0xFF34D399);

    final corDestaque = temaEscuro
        ? const Color(0xFF1B3028)
        : const Color(0xFFE6F7EF);

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          'Sobre o aplicativo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: temaEscuro ? verdeBarraEscura : verdeEscuro,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Card(
            color: tema.cardColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: corDestaque,
                    child: Icon(
                      Icons.task_alt,
                      size: 65,
                      color: temaEscuro ? verdeClaro : verdeEscuro,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    'Gerenciador de Tarefas',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cores.onSurface,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'Organização e gerenciamento de tarefas pessoais.',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.bodyLarge?.copyWith(
                      color: cores.onSurface.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: corDestaque,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Versão 1.0.0',
                      style: TextStyle(
                        color: temaEscuro ? verdeClaro : verdeEscuro,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 10),

                  Text(
                    'Desenvolvido por Leonardo Viana',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.bodyMedium?.copyWith(
                      color: cores.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
