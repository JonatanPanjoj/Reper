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
    //TODO: Ordenar por secciones
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
    GoRoute(
      path: '/repertory',
      builder: (context, state) {
        return RepertoryScreen(repertory: state.extra as Repertory);
      },
    ),
    GoRoute(
      path: '/song-screen',
      builder: (context, state) {
        return SongScreen(song: state.extra as Song);
      },
    ),
    GoRoute(
      path: '/create-song',
      builder: (context, state) {
        return const CreateSongScreen();
      },
    ),
    GoRoute(
      path: '/edit-song-screen',
      builder: (context, state) {
        return EditSongScreen(
          song: state.extra as Song,
        );
      },
    ),
    GoRoute(
      path: '/section-screen',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return SectionScreen(
          repertory: extras['repertory'] as Repertory,
          section: extras['section'] as Section,
          image: extras['image'] as String,
          song: extras['song'] as Song,
        );
      },
    ),
    GoRoute(
      path: '/library-screen',
      builder: (context, state) {
        return const LibraryView(
          isaddSongScreen: true,
        );
      },
    ),
    GoRoute(
      path: '/add-repertory-event-screen',
      builder: (context, state) {
        return AddRepertoryEventScreen(repertory: state.extra as Repertory);
      },
    ),
    GoRoute(
      path: '/edit-group-screen',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return EditGroupScreen(
          group: extras['group'] as Group,
        );
      },
    ),
    GoRoute(
      path: '/notifications-screen',
      builder: (context, state) {
        return const NotificationsScreen();
      },
    ),
    GoRoute(
      path: '/add-friend-screen',
      builder: (context, state) {
        return const SocialView(
          isAddFriendScreen: true,
        );
      },
    ),
    GoRoute(
      path: '/edit-profile-screen',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return EditProfileScreen(
          user: extras['user'] as AppUser,
        );
      },
    ),
    GoRoute(
      path: '/edit-repertory-screen',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return EditRepertoryScreen(
          repertory: extras['repertory'] as Repertory,
        );
      },
    ),
  ],
);
