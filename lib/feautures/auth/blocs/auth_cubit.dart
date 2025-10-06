import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final user = _auth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(userId: user.uid, email: user.email ?? ''));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signUp(String email, String password, String userName) async {
    try {
      emit(AuthLoading());
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateProfile(displayName: userName);
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'key': credential.user!.uid,
          'name': userName,
          'email': email,
        });
        emit(AuthAuthenticated(
          userId: credential.user!.uid,
          email: credential.user!.email ?? '',
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        emit(AuthAuthenticated(
          userId: credential.user!.uid,
          email: credential.user!.email ?? '',
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }

  Future<void> signInWithEmailLink(String email, String link) async {
    try {
      emit(AuthLoading());
      final credential = await _auth.signInWithEmailLink(
        email: email,
        emailLink: link,
      );
      if (credential.user != null) {
        emit(AuthAuthenticated(
          userId: credential.user!.uid,
          email: credential.user!.email ?? '',
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }
  

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Failed to sign out'));
    }
  }

  String _handleError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-exists':
          return 'This email is already registered.';
        case 'invalid-email':
          return 'The email address is invalid.';
        case 'invalid-password':
          return 'The password is invalid.';
        default:
          return 'An error occurred: ${error.message}';
      }
    }
    return 'An unexpected error occurred.';
  }
}