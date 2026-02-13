import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../viewmodel/auth_bloc.dart';
import '../viewmodel/auth_event.dart';
import '../viewmodel/auth_state.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final _formKey = GlobalKey<FormBuilderState>();

  Widget otpBox(String name, {bool autoFocus = false}) {
    return SizedBox(
      width: 56,
      height: 56,
      child: FormBuilderTextField(
        style: TextStyle(color: Colors.black),
        name: name,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: FormBuilderValidators.required(errorText: 'OTP'),
        onChanged: (value) {
          if (value != null && value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
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
          context.go("/");
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                const Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                const Text(
                  'We have sent an OTP code to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                const SizedBox(height: 6),

                const Text(
                  'user@gmail.com',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    otpBox('otp1', autoFocus: true),
                    otpBox('otp2'),
                    otpBox('otp3'),
                    otpBox('otp4'),
                  ],
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();

                      if (_formKey.currentState!.validate()) {
                        final values = _formKey.currentState!.value;

                        final otp =
                            values['otp1'] +
                            values['otp2'] +
                            values['otp3'] +
                            values['otp4'];

                        context.read<UserBloc>().add(VerifyEvent(otp));
                        (context).go("/home");
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
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                GestureDetector(
                  onTap: () {
                    context.go("/");
                  },
                  child: const Text(
                    'Remembered password? Sign in',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
