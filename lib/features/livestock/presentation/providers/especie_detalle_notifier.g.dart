// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especie_detalle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$especieDetalleHash() => r'2ad7e696a65888460929fcd06a57af6835180c61';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EspecieDetalle
    extends BuildlessAutoDisposeAsyncNotifier<EspecieDetalleState> {
  late final String especieId;

  FutureOr<EspecieDetalleState> build(
    String especieId,
  );
}

/// See also [EspecieDetalle].
@ProviderFor(EspecieDetalle)
const especieDetalleProvider = EspecieDetalleFamily();

/// See also [EspecieDetalle].
class EspecieDetalleFamily extends Family<AsyncValue<EspecieDetalleState>> {
  /// See also [EspecieDetalle].
  const EspecieDetalleFamily();

  /// See also [EspecieDetalle].
  EspecieDetalleProvider call(
    String especieId,
  ) {
    return EspecieDetalleProvider(
      especieId,
    );
  }

  @override
  EspecieDetalleProvider getProviderOverride(
    covariant EspecieDetalleProvider provider,
  ) {
    return call(
      provider.especieId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'especieDetalleProvider';
}

/// See also [EspecieDetalle].
class EspecieDetalleProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EspecieDetalle, EspecieDetalleState> {
  /// See also [EspecieDetalle].
  EspecieDetalleProvider(
    String especieId,
  ) : this._internal(
          () => EspecieDetalle()..especieId = especieId,
          from: especieDetalleProvider,
          name: r'especieDetalleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$especieDetalleHash,
          dependencies: EspecieDetalleFamily._dependencies,
          allTransitiveDependencies:
              EspecieDetalleFamily._allTransitiveDependencies,
          especieId: especieId,
        );

  EspecieDetalleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.especieId,
  }) : super.internal();

  final String especieId;

  @override
  FutureOr<EspecieDetalleState> runNotifierBuild(
    covariant EspecieDetalle notifier,
  ) {
    return notifier.build(
      especieId,
    );
  }

  @override
  Override overrideWith(EspecieDetalle Function() create) {
    return ProviderOverride(
      origin: this,
      override: EspecieDetalleProvider._internal(
        () => create()..especieId = especieId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        especieId: especieId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EspecieDetalle, EspecieDetalleState>
      createElement() {
    return _EspecieDetalleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EspecieDetalleProvider && other.especieId == especieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, especieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EspecieDetalleRef
    on AutoDisposeAsyncNotifierProviderRef<EspecieDetalleState> {
  /// The parameter `especieId` of this provider.
  String get especieId;
}

class _EspecieDetalleProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EspecieDetalle,
        EspecieDetalleState> with EspecieDetalleRef {
  _EspecieDetalleProviderElement(super.provider);

  @override
  String get especieId => (origin as EspecieDetalleProvider).especieId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
