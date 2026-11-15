import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';
import 'themes/app_themes.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeService.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gerenciador de Tarefas',

          theme: AppThemes.claro,
          darkTheme: AppThemes.escuro,

          themeMode: ThemeService.instance.temaEscuro
              ? ThemeMode.dark
              : ThemeMode.light,

          home: StreamBuilder(
            stream: AuthService().estadoAutenticacao,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasData) {
                ThemeService.instance.carregarTema(snapshot.data!.uid);

                return const HomeScreen();
              }

              ThemeService.instance.carregarTema(null);

              return const LoginScreen();
            },
          ),
        );
      },
    );
  }
}
