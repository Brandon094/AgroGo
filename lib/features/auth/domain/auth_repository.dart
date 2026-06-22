import 'usuario_model.dart';

abstract class AuthRepository {
  Stream<Usuario?> get alAutenticar;
  Future<Usuario?> iniciarSesionGoogle();
  Future<void> cerrarSesion();
}
