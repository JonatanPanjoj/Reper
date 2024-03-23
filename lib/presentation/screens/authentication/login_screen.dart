// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/providers/auth/auth_repository_provider.dart';
import 'package:reper/presentation/providers/providers.dart';

import 'package:reper/presentation/widgets/widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    'La app de canciones con acordes!',
                    style: TextStyle(color: colors.dividerColor),
                  ),
                  const SizedBox(height: 95),
                  CustomFilledButton(
                    text: 'Ingresa por Correo',
                    icon: const Icon(Icons.email, color: Color(0xFFF0F2F5),),
                    onTap: () {
                      context.push('/login-by-email');
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    text: 'Ingresa con Google',
                    color: colors.colorScheme.onSurface,
                    fontColor: colors.colorScheme.surface,
                    icon: Image.asset(
                      'assets/img/google.png',
                      height: 30,
                      width: 30,
                    ),
                    onTap: () async {
                      final res =
                          await ref.read(authProvider).loginWithGoogle();

                      if (!res.hasError) {
                        // context.replace('/home/0');
                      }
                    },
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
