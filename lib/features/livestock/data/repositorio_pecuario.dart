import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/entidades_pecuario.dart';
import 'modelos_pecuario_isar.dart';

part 'repositorio_pecuario.g.dart';

abstract class RepositorioPecuario {
  Future<Either<Fallo, List<EspecieEntity>>> obtenerEspecies({int? fincaId});
  Future<Either<Fallo, void>> guardarEspecie(EspecieEntity especie);
  
  Future<Either<Fallo, List<ControlSanitarioEntity>>> obtenerControlesPorEspecie(String especieId);
  Future<Either<Fallo, void>> guardarControlSanitario(ControlSanitarioEntity control);
  
  Future<Either<Fallo, List<AlimentacionEntity>>> obtenerAlimentacionPorEspecie(String especieId);
  Future<Either<Fallo, void>> guardarAlimentacion(AlimentacionEntity alimentacion);
}

class RepositorioPecuarioImpl implements RepositorioPecuario {
  final Isar isar;
  RepositorioPecuarioImpl(this.isar);

  @override
  Future<Either<Fallo, List<EspecieEntity>>> obtenerEspecies({int? fincaId}) async {
    try {
      final query = isar.especieIsarModels.where();
      final resultados = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener especies', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarEspecie(EspecieEntity especie) async {
    try {
      final modelo = EspecieIsarModel.fromEntity(especie);
      await isar.writeTxn(() async => await isar.especieIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar especie', e));
    }
  }

  @override
  Future<Either<Fallo, List<ControlSanitarioEntity>>> obtenerControlesPorEspecie(String especieId) async {
    try {
      final idInt = int.parse(especieId);
      final resultados = await isar.controlSanitarioIsarModels
          .filter()
          .especieIdEqualTo(idInt)
          .findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener controles', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarControlSanitario(ControlSanitarioEntity control) async {
    try {
      final modelo = ControlSanitarioIsarModel.fromEntity(control);
      await isar.writeTxn(() async => await isar.controlSanitarioIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar control', e));
    }
  }

  @override
  Future<Either<Fallo, List<AlimentacionEntity>>> obtenerAlimentacionPorEspecie(String especieId) async {
    try {
      final idInt = int.parse(especieId);
      final resultados = await isar.alimentacionIsarModels
          .filter()
          .especieIdEqualTo(idInt)
          .findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener alimentación', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarAlimentacion(AlimentacionEntity alimentacion) async {
    try {
      final modelo = AlimentacionIsarModel.fromEntity(alimentacion);
      await isar.writeTxn(() async => await isar.alimentacionIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar alimentación', e));
    }
  }
}

@riverpod
RepositorioPecuario repositorioPecuario(RepositorioPecuarioRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioPecuarioImpl(isar);
}
