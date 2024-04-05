import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:reper/presentation/widgets/elements/custom_filled_button.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({Key? key}) : super(key: key);

  @override
  UpdateViewState createState() => UpdateViewState();
}

class UpdateViewState extends State<UpdateView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'A new update is available',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fade() // inherits duration from fadeIn
                        .move(
                            begin: const Offset(25, 0),
                            end: const Offset(0, 0),
                            delay: 0.ms,
                            curve: Curves
                                .easeOutBack) // runs after the above w/new duratio,
                    ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Please update to the latest version of the app to enjoy new features and bug fixes.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
                    .animate()
                    .fade() // inherits duration from fadeIn
                    .move(
                        begin: const Offset(25, 0),
                        end: const Offset(0, 0),
                        delay: 100.ms,
                        curve: Curves.easeOutBack),
                const SizedBox(height: 16),
                SizedBox(
                  child: Lottie.asset(
                    'assets/animations/update.json',
                  ),
                )
                    .animate()
                    .fade() // inherits duration from fadeIn
                    .move(
                        begin: const Offset(25, 0),
                        end: const Offset(0, 0),
                        delay: 200.ms,
                        curve: Curves.easeOutBack),
                const SizedBox(height: 16),
                SizedBox(
                  width: size.width * 0.8,
                  child: CustomFilledButton(
                    height: 50,
                    text: 'Update',
                    onTap: () async {
                      // final storeUrl = Platform.isIOS
                      //     ? 'https://apps.apple.com/us/app/dandy-the-move/id1494516404'
                      //     : 'https://play.google.com/store/apps/details?id=com.dandy.themove';
                      // if (await canLaunchUrl(Uri.parse(storeUrl))) {
                      //   await launchUrl(Uri.parse(storeUrl));
                      // } else {
                      //   throw 'Could not launch $storeUrl';
                      // }
                    },
                  )
                      .animate()
                      .fade() // inherits duration from fadeIn
                      .move(
                          begin: const Offset(25, 0),
                          end: const Offset(0, 0),
                          delay: 300.ms,
                          curve: Curves.easeOutBack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
