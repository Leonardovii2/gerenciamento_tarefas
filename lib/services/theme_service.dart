import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static final ThemeService instance = ThemeService._();

  ThemeService._();

  bool temaEscuro = false;
  String? _uidAtual;

  int _versaoCarregamento = 0;

  Future<void> carregarTema(String? uid) async {
    if (_uidAtual == uid) return;

    _uidAtual = uid;
    final versaoAtual = ++_versaoCarregamento;

    if (uid == null) {
      temaEscuro = false;
      notifyListeners();
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    // Evita aplicar o tema de uma conta anterior.
    if (versaoAtual != _versaoCarregamento || _uidAtual != uid) {
      return;
    }

    temaEscuro = prefs.getBool('tema_escuro_$uid') ?? false;

    notifyListeners();
  }

  Future<void> alterarTema(bool escuro) async {
    temaEscuro = escuro;
    notifyListeners();

    final uid = _uidAtual;

    if (uid != null) {
      final prefs = await SharedPreferences.getInstance();

      // Salva o tema da conta atual.
      if (_uidAtual == uid) {
        await prefs.setBool('tema_escuro_$uid', escuro);
      }
    }
  }
}
