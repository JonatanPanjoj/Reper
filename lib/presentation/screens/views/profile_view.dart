import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/entities/app_user.dart';
import 'package:reper/presentation/providers/providers.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    final userInfo = ref.watch(userProvider);
    final notifications = ref.watch(userNotificationListProvider);
    bool switchChanged = true;
    final colors = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 230,
              child: _buildBanner(colors, userInfo),
            ),
            const SizedBox(height: 10),
            _buildUserInfo(userInfo),
            const SizedBox(height: 10),
            _buildSettings(isDarkMode, switchChanged),
            const SizedBox(height: 10),
            // _buildUserSupport(),
            const SizedBox(
              height: 10,
            ),
            _buildLogOut(),
            _buildCurrentVersion()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/notifications-screen');
        },
        shape: const CircleBorder(),
        child: Stack(
          children: [
            const Icon(Icons.notifications),
            if (notifications.isNotEmpty)
              Positioned(
                right: 1,
                top: 2,
                child: SizedBox(
                  height: 9,
                  width: 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  FutureBuilder<PackageInfo> _buildCurrentVersion() {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const SizedBox();
          }

          final currentVersion = data.version;


          
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Version $currentVersion'),
          );
        },
      );
  }

  Widget _buildLogOut() {
    final colors = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Ayuda y soporte')],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Contáctanos')],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Política de Privacidad')],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Cambio de contraseña')],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettings(bool isDarkMode, bool switchChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      value: false,
                      onChanged: (newValue) {
                        setState(() {
                          switchChanged = newValue;
                        });
                      },
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

  Widget _buildUserInfo(AppUser user) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Miembro desde',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatDate(user.joinedAt),
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
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

  Widget _buildBanner(ThemeData colors, AppUser user) {
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
            user.image.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    radius: 65,
                  )
                : CircleAvatar(
                    radius: 65,
                    child: Text(
                      user.name.substring(0, 1),
                      style: const TextStyle(fontSize: 40),
                    ),
                  )
          ],
        ),
        // Positioned(
        //   top: 30,
        //   left: 20,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        //     width: 86,
        //     height: 29,
        //     decoration: BoxDecoration(
        //         image: const DecorationImage(
        //           alignment: Alignment(0.8, 0.05),
        //           scale: 30,
        //           image: AssetImage('assets/img/notas-musicales.png'),
        //         ),
        //         color: const Color.fromRGBO(241, 144, 0, 1),
        //         borderRadius: BorderRadius.circular(20)),
        //     child: const Text(
        //       'Premium',
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 10),
        //     ),
        //   ),
        // ),
        Positioned(
          top: 180,
          right: 20,
          child: GestureDetector(
              onTap: () {
                context.push('/edit-profile-screen', extra: {'user': user});
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
      ],
    );
  }
}
