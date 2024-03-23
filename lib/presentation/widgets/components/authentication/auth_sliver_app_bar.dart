import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthSliverAppBar extends StatelessWidget {
  const AuthSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    final screenSize = (size.height * 0.45);

    return SliverAppBar(
      expandedHeight: screenSize.round().toDouble(),
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
                'assets/img/rippy-logo.png',
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 10,
              child: Text(
                'Ingresa a Reper',
                style: GoogleFonts.urbanist(fontSize: 23, color: colors.colorScheme.onSurface),
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
