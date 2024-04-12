import 'package:flutter/material.dart';

class ToneButtons extends StatelessWidget {
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final void Function()? onIncrementSpeed;
  final void Function()? onDecrementSpeed;
  final double horizontalPadding;
  final MainAxisAlignment mainAxisAlignment;
  final int speed;

  const ToneButtons({
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.onIncrementSpeed,
    this.onDecrementSpeed,
    this.horizontalPadding = 20,
    this.mainAxisAlignment = MainAxisAlignment.start, 
    this.speed = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          
          Card(
            child: Row(
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: const Icon(Icons.remove),
                ),
                const Text(
                  'Tono',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Card(
            child: Row(
              children: [
                IconButton(
                  onPressed: onDecrementSpeed,
                  icon: const Icon(Icons.remove),
                ),
                Row(
                  children: [
                    const Icon(Icons.speed),
                    const SizedBox(width: 5),
                    Text(
                      speed.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onIncrementSpeed,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
