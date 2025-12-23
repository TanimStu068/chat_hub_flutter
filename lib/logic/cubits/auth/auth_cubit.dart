import 'dart:async';

import 'package:chat_hub/data/models/user_model.dart';
import 'package:chat_hub/data/repositories/auth_repository.dart';
import 'package:chat_hub/logic/cubits/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState()) {
    _init();
  }

  void _init() {
    emit(state.copyWith(status: AuthStatus.initial));

    _authStateSubscription = _authRepository.authStateChanges.listen((
      user,
    ) async {
      if (user != null) {
        try {
          final userData = await _authRepository.getUserData(user.uid);

          emit(
            state.copyWith(status: AuthStatus.authenticated, user: userData),
          );
        } catch (e) {
          emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
        }
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String fullName,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      // 1️⃣ Create Firebase Auth user and save extra info in Firestore
      final userModel = await _authRepository.signUp(
        fullName: fullName,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );

      // 2️⃣ Save the same user locally in Hive
      final box = Hive.box<UserModel>('userBox');
      await box.put(userModel.uid, userModel);

      // 3️⃣ Update Cubit state

      emit(state.copyWith(status: AuthStatus.signupSuccess, user: userModel));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.singOut();

      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      await _authRepository.sendPasswordResetEmail(email);

      emit(state.copyWith(status: AuthStatus.passwordResetEmailSent));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}
