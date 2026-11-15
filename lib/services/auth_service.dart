import 'package:firebase_auth/firebase_auth.dart';

import '../models/usuario.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Usuario? get usuarioAtual {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    return Usuario(
      uid: user.uid,
      nome: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  Future<Usuario> cadastrar(String nome, String email, String senha) async {
    final resultado = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );

    await resultado.user!.updateDisplayName(nome.trim());

    await _auth.signOut();

    return Usuario(
      uid: resultado.user!.uid,
      nome: nome.trim(),
      email: email.trim(),
    );
  }

  Future<Usuario> login(String email, String senha) async {
    final resultado = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );

    final user = resultado.user!;

    return Usuario(
      uid: user.uid,
      nome: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<User?> get estadoAutenticacao {
    return _auth.authStateChanges();
  }
}
