import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:reper/domain/datasources/auth_datasource.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/infrastructure/datasources/firebase_user_datasource.dart';

class FirebaseAuthDataSource extends AuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseUserDatasource userDatasource = FirebaseUserDatasource();

  @override
  Future<ResponseStatus> loginByEmailAndPassword(
      {required String email, required String password}) async {
    late final UserCredential? cred;
    try {
      cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return ResponseStatus(hasError: false, message: cred.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' ||
          e.code == 'wrong-password' ||
          e.code == 'user-not-found') {
        return ResponseStatus(hasError: true, message: 'Invalid Credentials');
      } else if (e.code == 'too-many-requests') {
        return ResponseStatus(hasError: true, message: 'Too many request');
      } else {
        return ResponseStatus(hasError: true, message: e.code.toUpperCase());
      }
    } catch (e) {
      return ResponseStatus(hasError: true, message: e.toString());
    }
  }

  @override
  Future<ResponseStatus> registerByEmailAndPassword({
    required String nickname,
    required String email,
    required String password,
  }) async {
    //Verify Nickname
    final ResponseStatus nickResponse =
        await userDatasource.validateNickname(nickname: nickname);
    if (nickResponse.hasError) {
      return nickResponse;
    }

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userDatasource.createUser(
        uid: cred.user!.uid,
        user: AppUser(
          uid: 'no-uid',
          name: nickname,
          email: email,
          joinedAt: Timestamp.now(),
        ),
      );
      return ResponseStatus(
        message: 'Usuario Registrado con Éxito',
        hasError: false,
      );
    } on FirebaseAuthException catch (e) {
      return _validateRegisterFirebaseError(e);
    } catch (e) {
      return ResponseStatus(
        message: 'The account already exists for that email.',
        hasError: true,
      );
    }
  }

  @override
  Future<void> signOut() async {
    GoogleSignIn().signOut();
    _auth.signOut();
  }

  //HELPERS
  ResponseStatus _validateRegisterFirebaseError(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      return ResponseStatus(
          message: 'The password provided is too weak.', hasError: true);
    } else if (e.code == 'email-already-in-use') {
      return ResponseStatus(
          message: 'The account already exists for that email.',
          hasError: true);
    } else {
      return ResponseStatus(hasError: true, message: e.code.toUpperCase());
    }
  }

  @override
  Future<ResponseStatus> loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
      final UserCredential cred = await _auth.signInWithCredential(credential);

      if (googleUser != null) {
        final userRes =
            await userDatasource.validateGoogleUser(id: googleUser.id);
        //NO ESTÁ CREADO EL USUARIO
        if (!userRes.hasError) {
          await userDatasource.createUser(
            user: AppUser(
              uid: cred.user!.uid,
              name: googleUser.displayName ?? 'No name',
              email: googleUser.email,
              joinedAt: Timestamp.now(),
              googleId: googleUser.id,
              groups: []
            ),
            uid: cred.user!.uid,
          );
          return ResponseStatus(message: 'success', hasError: false);
        }
      }
      return ResponseStatus(message: 'success', hasError: false);
    } catch (e) {
      return ResponseStatus(message: e.toString(), hasError: true);
    }
  }
}
