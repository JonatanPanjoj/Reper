import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reper/config/theme/app_font_styles.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando canciones',
      'Afinando instrumentos',
      '¿Ensayaste la canción?',
      'Preparándome para brillar',
      'Seleccionando acordes',
      'Cargando a Rippy',
      'Ya mero...',
      'Esto está tardando más de lo esperado :(',
    ];

    return Stream.periodic(const Duration(milliseconds: 1800), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitSpinningCircle(
                size:  size.width * 0.5,
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/img/rippy-logo.png',
                  );
                },
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: getLoadingMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Cargando...', style: bold18,);
                  return Text(snapshot.data!, style: bold18, textAlign: TextAlign.center,);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
