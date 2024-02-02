import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const AuthSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    'Registrate si no tienes una',
                    style: TextStyle(color: colors.dividerColor),
                  ),
                  const SizedBox(height: 95),
                  CustomFilledButton(
                    text: 'Ingresa por Correo',
                    icon: const Icon(Icons.email),
                    onTap: () {
                      context.push('/login-by-email');
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    text: 'Ingresa con Google',
                    color: const Color(0xFFF0F2F5),
                    fontColor: colors.scaffoldBackgroundColor,
                    icon: Image.asset(
                      'assets/img/google.png',
                      height: 30,
                      width: 30,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
