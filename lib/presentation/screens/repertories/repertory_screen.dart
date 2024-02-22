import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/config/theme/theme.dart';

import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class RepertoryScreen extends ConsumerStatefulWidget {
  final Repertory repertory;

  const RepertoryScreen({super.key, required this.repertory});

  @override
  RepertoryScreenState createState() => RepertoryScreenState();
}

class RepertoryScreenState extends ConsumerState<RepertoryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
          stream: ref.watch(repertoryRepositoryProvider).streamRepertory(
                id: widget.repertory.id,
                groupId: widget.repertory.groupId,
              ),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data == null) {
              return const Center(child: CustomLoading());
            }

            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  height: size.height * 0.2,
                  image: widget.repertory.image,
                  title: widget.repertory.name,
                  subtitle: '${widget.repertory.sections.length} canciones',
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {},
                      child: const Row(
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
                ),
                if (data.sections.isEmpty)
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Center(
                          child: Text('Aún no tienes canciones agregadas'),
                        ),
                      ],
                    ),
                  ),
                if (data.sections.isNotEmpty)
                  SliverList.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return const CardTypeThree(
                        title: 'Prueba',
                        subtitle: 'Imagen',
                      );
                    },
                  )
              ],
            );
          }),
    );
  }
}
