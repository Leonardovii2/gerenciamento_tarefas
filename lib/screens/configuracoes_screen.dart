import 'package:flutter/material.dart';

import '../services/theme_service.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;
    final modoEscuro = tema.brightness == Brightness.dark;

    const verdeEscuro = Color(0xFF047857);
    const verdeClaro = Color(0xFF065F46);
    const verdePrincipal = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: modoEscuro ? verdeClaro : verdeEscuro,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: AnimatedBuilder(
        animation: ThemeService.instance,
        builder: (context, child) {
          final temaEscuro = ThemeService.instance.temaEscuro;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: tema.cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),

                title: Text(
                  'Tema escuro',
                  style: tema.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: cores.onSurface,
                  ),
                ),

                subtitle: Text(
                  'Ativar ou desativar o tema escuro.',
                  style: tema.textTheme.bodyMedium?.copyWith(
                    color: cores.onSurface.withOpacity(0.7),
                  ),
                ),

                secondary: Icon(
                  Icons.dark_mode,
                  color: modoEscuro ? const Color(0xFF34D399) : verdeEscuro,
                ),

                value: temaEscuro,

                activeColor: Colors.white,
                activeTrackColor: verdePrincipal,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: modoEscuro
                    ? const Color(0xFF365448)
                    : const Color(0xFFD1E5D9),

                onChanged: (valor) {
                  ThemeService.instance.alterarTema(valor);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
