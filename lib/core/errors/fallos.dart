/// Clase base para todos los fallos o errores en la aplicación.
abstract class Fallo {
  final String mensaje;
  final dynamic error;

  const Fallo(this.mensaje, [this.error]);

  @override
  String toString() => mensaje;
}

/// Representa un fallo al comunicarse con un servidor o API remoto.
class FalloServidor extends Fallo {
  const FalloServidor(super.mensaje, [super.error]);
}

/// Representa un fallo relacionado con operaciones de base de datos local (ej. Isar).
class FalloBaseDatos extends Fallo {
  const FalloBaseDatos(super.mensaje, [super.error]);
}

/// Representa un fallo en el manejo de la caché local.
class FalloCache extends Fallo {
  const FalloCache(super.mensaje, [super.error]);
}

/// Representa un fallo de conexión a red.
class FalloConexion extends Fallo {
  const FalloConexion(super.mensaje, [super.error]);
}
