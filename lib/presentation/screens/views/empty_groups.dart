import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
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
        title: const Text(
          'Bienvenidos!'
        ),
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
                Bounce(
                  infinite: true,
                  child: Image.asset(
                    'assets/img/rippy-logo.png',
                    height: size.width * 0.5,
                    width: size.width * 0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    'Siempre es bueno ver caras nuevas!',
                  ),
                  const SizedBox(height: 20,),
                  CustomFilledButton(
                    text: 'Crear un Grupo',
                    onTap: () {
                      context.push('/create-group');
                    },
                  ),
                  const SizedBox(height: 15,),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        )
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('O'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  CustomFilledButton(
                    text: 'Unirme a un grupo',
                    onTap: () {
                      context.push('/create-group');
                    },
                  ),
                ],
              ),
            ),
          ),
                ],
                
              ),
        ));
  }
}
/*
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: Divider(
        color: Colors.white,
        thickness: 2,
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "OR",
        style: TextStyle(color: Colors.white),
      ),
    ),
    Expanded(
      child: Divider(
        color: Colors.white,
        thickness: 2,
      ),
    ),
  ],
)

*/
