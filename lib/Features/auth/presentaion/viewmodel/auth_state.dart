import 'package:flutter/material.dart';

abstract class AuthState {
  final ThemeMode themeMode;

  const AuthState({this.themeMode = ThemeMode.light});
}

class AuthInitial extends AuthState {
  const AuthInitial({super.themeMode});
}

class AuthLoading extends AuthState {
  const AuthLoading({required ThemeMode themeMode})
    : super(themeMode: themeMode);
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required ThemeMode themeMode})
    : super(themeMode: themeMode);
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message, {required ThemeMode themeMode})
    : super(themeMode: themeMode);
}
