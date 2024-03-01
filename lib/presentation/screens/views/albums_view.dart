import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reper/config/theme/app_font_styles.dart';

class AlbumsView extends ConsumerStatefulWidget {
  const AlbumsView({super.key});

  @override
  AlbumsViewState createState() => AlbumsViewState();
}

class AlbumsViewState extends ConsumerState<AlbumsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPumpingHeart(
            duration: const Duration(seconds: 5),
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/img/rippy-logo.png',
                width: size.width * 0.5,
                height: size.width * 0.5,
              );
            },
          ),
          const SizedBox(height: 60),
          const Text(
            'Próximamente...',
            style: bold22,
          ),
        ],
      )),
    );
  }
}
