import 'package:firebase_auth/firebase_auth.dart';

class UserAuthModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;

  UserAuthModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  factory UserAuthModel.fromFirebaseUser(User firebaseUser) {
    return UserAuthModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      photoURL: firebaseUser.photoURL ?? '',
    );
  }
}
