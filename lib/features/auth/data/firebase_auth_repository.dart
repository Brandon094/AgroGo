import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/auth_repository.dart';
import '../domain/usuario_model.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Stream<Usuario?> get alAutenticar {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return Usuario(
        id: user.uid,
        nombre: user.displayName,
        email: user.email,
        fotoUrl: user.photoURL,
      );
    });
  }

  @override
  Future<Usuario?> iniciarSesionGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final firebase.AuthCredential credential = firebase.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebase.UserCredential userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user == null) return null;

    return Usuario(
      id: user.uid,
      nombre: user.displayName,
      email: user.email,
      fotoUrl: user.photoURL,
    );
  }

  @override
  Future<void> cerrarSesion() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
