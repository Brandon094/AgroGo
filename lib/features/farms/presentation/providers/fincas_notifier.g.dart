// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fincas_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fincaActualHash() => r'549ed988530ac9aa1c31bee3fc8ff1706fab412f';

/// See also [fincaActual].
@ProviderFor(fincaActual)
final fincaActualProvider = AutoDisposeFutureProvider<FincaEntity?>.internal(
  fincaActual,
  name: r'fincaActualProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fincaActualHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FincaActualRef = AutoDisposeFutureProviderRef<FincaEntity?>;
String _$fincasNotifierHash() => r'baa16291aeeb71a5053cfdc76b90f7e3acf9bb7a';

/// See also [FincasNotifier].
@ProviderFor(FincasNotifier)
final fincasNotifierProvider = AutoDisposeAsyncNotifierProvider<FincasNotifier,
    List<FincaEntity>>.internal(
  FincasNotifier.new,
  name: r'fincasNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fincasNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FincasNotifier = AutoDisposeAsyncNotifier<List<FincaEntity>>;
String _$fincaSeleccionadaHash() => r'64fe69efe957c8abba18b887cd2435201311db30';

/// Provider para mantener el ID de la finca seleccionada actualmente
///
/// Copied from [FincaSeleccionada].
@ProviderFor(FincaSeleccionada)
final fincaSeleccionadaProvider =
    NotifierProvider<FincaSeleccionada, String?>.internal(
  FincaSeleccionada.new,
  name: r'fincaSeleccionadaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fincaSeleccionadaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FincaSeleccionada = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
