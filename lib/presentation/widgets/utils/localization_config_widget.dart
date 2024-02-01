import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationConfigWidget extends StatelessWidget {
  final Widget child;

  const LocalizationConfigWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es'),
      ],
      child: child,
    );
  }
}
