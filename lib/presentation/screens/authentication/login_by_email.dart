// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/auth/auth_repository_provider.dart';
import 'package:reper/presentation/providers/providers.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class LoginByEmailScreen extends ConsumerStatefulWidget {
  const LoginByEmailScreen({super.key});

  @override
  LoginByEmailScreenState createState() => LoginByEmailScreenState();
}

class LoginByEmailScreenState extends ConsumerState<LoginByEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              _buildEmailInput(),
              const SizedBox(height: 15),
              _buildPasswordInput(),
              const SizedBox(height: 60),
              _buildLoginButton(),
              const SizedBox(height: 25),
              _buildFormHaveAnAccount(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// COMPONENTS
  Widget _buildEmailInput() {
    final colors = Theme.of(context);
    return CustomInput(
      label: 'Email:',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      fillColor: colors.cardColor,
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
    final colors = Theme.of(context);
    return CustomInput(
      label: 'Password:',
      isPassword: obscureText,
      controller: _passwordController,
      fillColor: colors.cardColor,
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

  Widget _buildLoginButton() {
    return CustomFilledButton(
      isLoading: isLoading,
      text: 'Ingresar',
      onTap: () {
        _login();
      },
    );
  }

  Widget _buildFormHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No tienes una cuenta? '),
        GestureDetector(
          onTap: () {
            context.replace('/register-by-email');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              "Crea una",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  /// FUNCTIONS
  void _login() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      final ResponseStatus res =
          await ref.read(authProvider).loginByEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
              );
      isLoading = false;
      setState(() {});
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
