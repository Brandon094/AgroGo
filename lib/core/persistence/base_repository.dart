import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../errors/fallos.dart';

/// Clase base para centralizar la lógica de persistencia y manejo de errores de Isar.
abstract class BaseRepository {
  final Isar isar;

  BaseRepository(this.isar);

  /// Ejecuta una operación de escritura dentro de una transacción segura.
  Future<Either<Fallo, T>> ejecutarEscritura<T>(
    Future<T> Function() operacion, {
    String mensajeError = 'Error al guardar datos',
  }) async {
    try {
      final resultado = await isar.writeTxn(operacion);
      return Right(resultado);
    } catch (e) {
      return Left(FalloBaseDatos(mensajeError, e));
    }
  }

  /// Ejecuta una consulta de lectura con manejo de errores estandarizado.
  Future<Either<Fallo, T>> ejecutarLectura<T>(
    Future<T> Function() consulta, {
    String mensajeError = 'Error al consultar datos',
  }) async {
    try {
      final resultado = await consulta();
      return Right(resultado);
    } catch (e) {
      return Left(FalloBaseDatos(mensajeError, e));
    }
  }
}
