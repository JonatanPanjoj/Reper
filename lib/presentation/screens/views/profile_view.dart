import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/providers/auth/auth_repository_provider.dart';
import 'package:reper/presentation/providers/theme/theme_provider.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    bool switchChanged = true;
    final colors = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 230,
            child: _buildBanner(colors),
          ),
          const SizedBox(height: 20),
          _buildUserInfo(),
          const SizedBox(height: 10),
          _buildSettings(isDarkMode, switchChanged),
          const SizedBox(height: 10),
          _buildUserSupport(),
          const SizedBox(
            height: 10,
          ),
          _buildLogOut()
        ],
      ),
    );
  }

  Widget _buildLogOut() {
    final colors = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(authProvider).signOut();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cerrar Sesión',
                        style: TextStyle(color: colors.colorScheme.error),
                      ),
                      Icon(Icons.login_rounded, color: colors.colorScheme.error)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildUserSupport() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Ayuda y soporte')],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Contáctanos')],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Política de Privacidad')],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Cambio de contraseña')],
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettings(bool isDarkMode, bool switchChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Theme Mode',
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                      icon: Icon(isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                      onPressed: () {
                        ref
                            .read(themeNotifierProvider.notifier)
                            .toggleDarkMode();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(fontSize: 15),
                    ),
                    Switch(
                      value: switchChanged,
                      onChanged: (value) {
                        setState(() {
                          switchChanged = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildUserInfo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        Card(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Joix',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Miembro desde',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '1 de febrero de 2024',
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildBanner(ThemeData colors) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 165,
              decoration: BoxDecoration(
                gradient: ref.watch(gradientNotifierProvider),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colors.scaffoldBackgroundColor,
              radius: 70,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/img/userProfile.jpg'),
              radius: 65,
            ),
          ],
        ),
        Positioned(
          top: 30,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            width: 86,
            height: 29,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  alignment: Alignment(0.8, 0.05),
                  scale: 30,
                  image: AssetImage('assets/img/notas-musicales.png'),
                ),
                color: const Color.fromRGBO(241, 144, 0, 1),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Premium',
              style: TextStyle(
                  color: colors.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
            ),
          ),
        ),
        Positioned(
          top: 180,
          right: 20,
          child: GestureDetector(
              onTap: () {
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                width: 69,
                height: 30,
                decoration: BoxDecoration(
                    color: colors.cardColor,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
        Positioned(
          top: 30,
          right: 20,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C5DD3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications, size: 30,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
