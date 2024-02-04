import 'package:flutter/material.dart';
import 'package:reper/config/theme/theme.dart';

class CardTypeOne extends StatelessWidget {
  const CardTypeOne({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
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
                child: Image.asset(
                  'assets/img/login.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Los Pikachu',
                    style: bold18,
                  ),
                  SizedBox(height: 2),
                  Text('4 miembros, 10 repes'),
                  SizedBox(height: 2),
                  Row(
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
    );
  }
}
