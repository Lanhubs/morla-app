import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService extends GetxService {
  late final GoogleSignIn _googleSignIn;

  Future<GoogleAuthService> init() async {
    _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    return this;
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print('Google Sign-In Error: $error');
      return null;
    }
  }

  Future<String?> getIdToken() async {
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) return null;

      final authentication = await account.authentication;
      return authentication.idToken;
    } catch (error) {
      print('Get ID Token Error: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print('Google Sign-Out Error: $error');
    }
  }

  bool get isSignedIn => _googleSignIn.currentUser != null;

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}
