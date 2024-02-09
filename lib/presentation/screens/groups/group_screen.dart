import 'package:flutter/material.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class GroupScreen extends StatelessWidget {
  final Group group;

  const GroupScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: group.name,
            subtitle: '${group.reps.length} canciones',
            height: size.height * 0.5,
            image: group.image,
            bottomAction: IconButton(
              onPressed: () {
                showCustomDialog(
                  context: context,
                  alertDialog: AddReperDialog(groupId: group.id),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (group.reps.isEmpty)
                    const Column(
                      children: [
                        SizedBox(height: 50),
                        Text('Aún no tienes repertorios creados'),
                      ],
                    ),

                  //soy tonto los reps en subcolección y un stream con el ID del grupo y ya jeje

                  //PODRÍA OBTENER EL GRUPO DE LA LISTA DE GRUPOS CON .CONTAINS
                  //POR MEDIO DEL ID AL PROVIDER DE LISTA DE GRUPOS, ESO CREO QUE VA A FUNCIONAR
                  //SI NO SE ACTUALIZA NORMAL.
                  //AQUÍ TIENE QUE HABER UN STREAM AL GRUPO POR EL ID

                  // const CardTypeTwo(
                  //   animateFrom: 100,
                  //   subtitle: '8 canciones',
                  //   title: 'Misa de Don Bosco',
                  //   imageUrl:
                  //       'https://media.discordapp.net/attachments/847434893180141598/931607942019547156/242461551_397103211780526_8417705845192633533_n.png?ex=65cfa201&is=65bd2d01&hm=39b0736e571e05307bdabd767512e4fd6c2700263172a6362e25ff7731020859&=&format=webp&quality=lossless&width=671&height=671',
                  // ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
