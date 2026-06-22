class Usuario {
  final String id;
  final String? nombre;
  final String? email;
  final String? fotoUrl;

  Usuario({
    required this.id,
    this.nombre,
    this.email,
    this.fotoUrl,
  });
}
