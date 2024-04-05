import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/presentation/widgets/elements/custom_filled_button.dart';

class NoGroupsView extends ConsumerStatefulWidget {
  const NoGroupsView({super.key});

  @override
  NoGroupsViewState createState() => NoGroupsViewState();
}

class NoGroupsViewState extends ConsumerState<NoGroupsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenido!'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.58,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Lottie.asset(
                        'assets/animations/bubbles.json',
                        repeat: true,
                      ),
                    ),
                    SpinKitPumpingHeart(
                        duration: const Duration(seconds: 5),
                        itemBuilder: (context, index) {
                          return Image.asset(
                            'assets/img/rippy-logo.png',
                            height: size.width * 0.45,
                            width: size.width * 0.45,
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Text(
                      'Siempre es bueno ver caras nuevas!',
                      style: bold16,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomFilledButton(
                      text: 'Crear un Grupo',
                      onTap: () {
                        context.push('/create-group');
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
