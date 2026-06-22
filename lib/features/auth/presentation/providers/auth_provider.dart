import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/auth_repository.dart';
import '../../data/firebase_auth_repository.dart';
import '../../domain/usuario_model.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return FirebaseAuthRepository();
}

@riverpod
Stream<Usuario?> alAutenticar(AlAutenticarRef ref) {
  return ref.watch(authRepositoryProvider).alAutenticar;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> loginConGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).iniciarSesionGoogle();
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).cerrarSesion();
    });
  }
}
