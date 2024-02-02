import 'package:flutter/material.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class LoginByEmailScreen extends StatefulWidget {
  const LoginByEmailScreen({super.key});

  @override
  State<LoginByEmailScreen> createState() => _LoginByEmailScreenState();
}

class _LoginByEmailScreenState extends State<LoginByEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const AuthSliverAppBar(),
          const SliverSizedBox(height: 25),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                      label: 'Email:',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomInput(
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
                    ),
                    const SizedBox(height: 60),
                    CustomFilledButton(
                      text: 'Ingresar',
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
