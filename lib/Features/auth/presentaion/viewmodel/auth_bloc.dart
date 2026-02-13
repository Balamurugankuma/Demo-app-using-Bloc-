import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class UserBloc extends Bloc<AuthEvent, AuthState> {
  UserBloc() : super(const AuthInitial()) {
    on<LoginUserNameEvent>((event, emit) async {
      emit(AuthLoading(themeMode: state.themeMode));
      await Future.delayed(const Duration(seconds: 1));

      if (event.email.isNotEmpty) {
        emit(AuthSuccess(themeMode: state.themeMode));
      } else {
        emit(AuthFailure("Email cannot be empty", themeMode: state.themeMode));
      }
    });

    on<LoginPasswordEvent>((event, emit) async {
      emit(AuthLoading(themeMode: state.themeMode));
      await Future.delayed(const Duration(seconds: 1));

      if (event.password.length >= 6) {
        emit(AuthSuccess(themeMode: state.themeMode));
      } else {
        emit(
          AuthFailure(
            "Password must be 6 characters",
            themeMode: state.themeMode,
          ),
        );
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading(themeMode: state.themeMode));
      await Future.delayed(const Duration(seconds: 1));

      if (event.name.isNotEmpty && event.email.isNotEmpty) {
        emit(AuthSuccess(themeMode: state.themeMode));
      } else {
        emit(AuthFailure("All fields required", themeMode: state.themeMode));
      }
    });

    on<SignUpPasswordEvent>((event, emit) async {
      emit(AuthLoading(themeMode: state.themeMode));
      await Future.delayed(const Duration(seconds: 1));

      if (event.password != event.confirmPassword) {
        emit(AuthFailure("Passwords do not match", themeMode: state.themeMode));
        return;
      }

      emit(AuthSuccess(themeMode: state.themeMode));
    });

    on<VerifyEvent>((event, emit) async {
      emit(AuthLoading(themeMode: state.themeMode));
      await Future.delayed(const Duration(seconds: 1));

      if (event.otp == "1234") {
        emit(AuthSuccess(themeMode: state.themeMode));
      } else {
        emit(AuthFailure("Invalid OTP", themeMode: state.themeMode));
      }
    });

    on<ToggleThemeEvent>((event, emit) {
      final newTheme = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

      if (state is AuthLoading) {
        emit(AuthLoading(themeMode: newTheme));
      } else if (state is AuthSuccess) {
        emit(AuthSuccess(themeMode: newTheme));
      } else if (state is AuthFailure) {
        emit(AuthFailure((state as AuthFailure).message, themeMode: newTheme));
      } else {
        emit(AuthInitial(themeMode: newTheme));
      }
    });
  }
}
