import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      builder: (context, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

            if (snapshot.hasData) {
              return HomeScreen(pageIndex: pageIndex);
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/group-screen',
      builder: (context, state) {
        return GroupScreen(group: state.extra as Group);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/login-by-email',
      builder: (context, state) {
        return const LoginByEmailScreen();
      },
    ),
    GoRoute(
      path: '/register-by-email',
      builder: (context, state) {
        return const RegisterByEmailScreen();
      },
    ),
    GoRoute(
      path: '/create-group',
      builder: (context, state) {
        return const CreateGroupScreen();
      },
    ),
    
  ],
);
