import 'package:flutter/material.dart';
import 'package:reper/config/theme/theme.dart';

import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class RepertoryScreen extends StatelessWidget {
  final Repertory repertory;

  const RepertoryScreen({super.key, required this.repertory});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            height: size.height * 0.2,
            image: repertory.image,
            title: repertory.name,
            subtitle: '${repertory.sections.length} canciones',
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Agregar una canción',
                    style: normal20,
                  )
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return const CardTypeThree(
                  title: 'Prueba',
                  subtitle: 'Imagen',
                );
            },
          )
        ],
      ),
    );
  }
}
