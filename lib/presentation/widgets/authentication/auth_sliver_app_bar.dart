import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthSliverAppBar extends StatelessWidget {
  const AuthSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);

    return SliverAppBar(
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
    );
  }
}
