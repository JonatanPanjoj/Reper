import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.45,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(0),
              title: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.1, 1],
                          colors: [
                            Colors.transparent,
                            colors.scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    child: Image.asset(
                      'assets/img/logo.png',
                      width: 55,
                      height: 55,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      'Ingresa a Reper',
                      style: GoogleFonts.urbanist(fontSize: 23),
                    ),
                  ),
                ],
              ),
              background: Stack(
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      'assets/img/login.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    onTap: () {},
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
