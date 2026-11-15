class Usuario {
  String uid;
  String nome;
  String email;

  Usuario({required this.uid, required this.nome, required this.email});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'nome': nome, 'email': email};
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(uid: map['uid'], nome: map['nome'], email: map['email']);
  }
}
