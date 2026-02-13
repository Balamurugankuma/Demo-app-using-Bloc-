import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/auth_bloc.dart';
import '../viewmodel/auth_event.dart';
import '../viewmodel/auth_state.dart';

class SignUpPagePassword extends StatefulWidget {
  const SignUpPagePassword({super.key});

  @override
  State<SignUpPagePassword> createState() => _SignUpPagePasswordState();
}

class _SignUpPagePasswordState extends State<SignUpPagePassword> {
  final _formkey = GlobalKey<FormBuilderState>();

  Widget socialLogo({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthSuccess) {
          Navigator.pop(context);
          context.go("/Verify");
        }

        if (state is AuthFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      child: Scaffold(
        appBar: AppBar(elevation: 0),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FormBuilder(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Center(
                  child: Text(
                    'Set Password',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 80),

                const Text(
                  'Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 8),

                FormBuilderTextField(
                  name: 'password',
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: ' password',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.remove_red_eye),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Enter password'),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: 'password length should be minimum 6',
                    ),
                  ]),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 8),

                FormBuilderTextField(
                  name: 'confirm password',
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'confirm password',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.remove_red_eye),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Enter password'),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: 'password length should be minimum 6',
                    ),
                  ]),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _formkey.currentState!.save();

                      if (_formkey.currentState!.validate()) {
                        final password =
                            _formkey.currentState!.value['password'];

                        final confirmPassword =
                            _formkey.currentState!.value['confirm password'];

                        context.read<UserBloc>().add(
                          SignUpPasswordEvent(password, confirmPassword),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        context.go("/");
                      },
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialLogo(
                      icon: FontAwesomeIcons.google,
                      bgColor: const Color(0xFFF2F2F2),
                      iconColor: Colors.red,
                    ),
                    const SizedBox(width: 16),
                    socialLogo(
                      icon: FontAwesomeIcons.apple,
                      bgColor: Colors.black,
                      iconColor: Colors.white,
                    ),
                    const SizedBox(width: 16),
                    socialLogo(
                      icon: FontAwesomeIcons.facebookF,
                      bgColor: const Color(0xFF1877F2),
                      iconColor: Colors.white,
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
