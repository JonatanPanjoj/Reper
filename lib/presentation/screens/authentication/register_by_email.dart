// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/auth/auth_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class RegisterByEmailScreen extends ConsumerStatefulWidget {
  const RegisterByEmailScreen({super.key});

  @override
  RegisterByEmailScreenState createState() => RegisterByEmailScreenState();
}

class RegisterByEmailScreenState extends ConsumerState<RegisterByEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const AuthSliverAppBar(),
          const SliverSizedBox(height: 25),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNicknameInput(),
              const SizedBox(height: 15),
              _buildEmailInput(),
              const SizedBox(height: 15),
              _buildPasswordInput(),
              const SizedBox(height: 15),
              _buildConfirmPasswordInput(),
              const SizedBox(height: 60),
              _buildLoginButton(),
              const SizedBox(height: 25),
              _buildFormHaveAnAccount()
            ],
          ),
        ),
      ),
    );
  }

  /// COMPONENTS
  Widget _buildNicknameInput() {
    return CustomInput(
      label: 'Nickname:',
      controller: _nicknameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu Nickname';
        }
        return null;
      },
    );
  }

  Widget _buildEmailInput() {
    return CustomInput(
      label: 'Email:',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa tu email';
        } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return 'Email Invalido';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordInput() {
    return CustomInput(
      label: 'Password:',
      isPassword: obscureText,
      controller: _passwordController,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          obscureText = !obscureText;
          setState(() {});
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingresa la contraseña';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordInput() {
    return CustomInput(
      label: 'Confirm Password:',
      isPassword: obscureText,
      controller: _confirmPasswordController,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          obscureText = !obscureText;
          setState(() {});
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Porfavor confirma tu contraseña';
        } else if (value != _passwordController.text) {
          return 'Las contraseñas no coinciden';
        }
        return null;
      },
    );
  }

  

  Widget _buildLoginButton() {
    return CustomFilledButton(
      text: 'Ingresar',
      onTap: () {
        _register();
      },
    );
  }

  Widget _buildFormHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Ya tienes una cuenta? '),
        GestureDetector(
          onTap: () {
            context.replace('/login-by-email');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              "Ingresa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  /// FUNCTIONS
  void _register() async {
    if (_formKey.currentState!.validate()) {
      final ResponseStatus res =
          await ref.read(authProvider).registerByEmailAndPassword(
                nickname: _nicknameController.text,
                email: _emailController.text,
                password: _passwordController.text, 
              );
      if (res.hasError) {
        showSnackbarResponse(
          context: context,
          response: res,
        );
      } else {
        context.replace('/home/0');
      }
    }
  }
}
