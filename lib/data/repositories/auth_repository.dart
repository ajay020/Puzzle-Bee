import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:puzzle_bee/data/models/user/user_model.dart';
import 'package:puzzle_bee/data/repositories/user_repository_impl.dart';
import 'package:puzzle_bee/data/services/user_cache_service.dart';
import 'package:puzzle_bee/domain/repositories/user_repository.dart';

import '../models/user/user_auth_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserRepository _userRepository = UserRepositoryImpl(
    firestore: FirebaseFirestore.instance,
    cacheService: UserCacheService(),
  );

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Stream<UserAuthModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      return user != null ? UserAuthModel.fromFirebaseUser(user) : null;
    });
  }

  UserAuthModel? get currentUser => _firebaseAuth.currentUser != null
      ? UserAuthModel.fromFirebaseUser(_firebaseAuth.currentUser!)
      : null;

  Future<UserAuthModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Sign in aborted by user');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Create or update user document in Firestore
      if (userCredential.user != null) {
        await _createOrUpdateUserDocument(userCredential.user!);
        return UserAuthModel.fromFirebaseUser(userCredential.user!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  Future<void> _createOrUpdateUserDocument(User firebaseUser) async {
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);

    final doc = await userDoc.get();

    final UserModel user;

    if (doc.exists) {
      user = UserModel.fromJson(doc.data()!);
      _userRepository.saveUser(user);
    } else {
      user = UserModel(
        userId: firebaseUser.uid,
        username: firebaseUser.displayName ?? "User",
        photoURL: firebaseUser.photoURL ?? "",
      );
      _userRepository.saveUser(user);
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }
}
