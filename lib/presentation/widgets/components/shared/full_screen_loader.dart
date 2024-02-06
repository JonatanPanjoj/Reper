import 'package:flutter/material.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando campeones',
      'Randomizando Items',
      'Carreando Yasuos',
      'Preparándome para carrear, o al menos para no feedear.',
      'Seleccionando runas y rezando por crits.',
      'Cargando habilidades y buscando excusas. ',
      'Ya mero...',
      'Esto está tardando más de lo esperado :(',
    ];

    return Stream.periodic(const Duration(milliseconds: 1800), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Espere por favor'),
            const SizedBox(height: 20),
            const CustomLoading(),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: getLoadingMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando...');
                return Text(snapshot.data!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
