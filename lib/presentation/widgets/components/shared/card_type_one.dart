import 'package:flutter/material.dart';
import 'package:reper/config/theme/theme.dart';

class CardTypeOne extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final void Function()? onTap;

  const CardTypeOne({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                height: size.width * 0.25,
                width: size.width * 0.223,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: bold18,
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle),
                    const SizedBox(height: 2),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 9,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Text('Active')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
