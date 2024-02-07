import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class GroupScreen extends StatelessWidget {
  final Group group;

  const GroupScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenSize = (size.height * 0.5);
    final colors = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenSize.round().toDouble(),
            titleSpacing: 0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0),
              title: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.1, 1],
                          colors: [
                            Colors.transparent,
                            colors.scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 35,
                    left: 20,
                    child: Text(
                      group.name,
                      style: GoogleFonts.urbanist(fontSize: 25).copyWith(
                          color: colors.colorScheme.onSurface,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      '8 miembros',
                      style: GoogleFonts.urbanist(fontSize: 12).copyWith(
                        color: colors.colorScheme.onSurface,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 20,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    ),
                  )
                ],
              ),
              background: Stack(
                children: [
                  SizedBox.expand(
                    child: Image.network(
                      group.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CardTypeTwo(
                    animateFrom: 100,
                    subtitle: '8 canciones',
                    title: 'Misa de Don Bosco',
                    imageUrl:
                        'https://media.discordapp.net/attachments/847434893180141598/931607942019547156/242461551_397103211780526_8417705845192633533_n.png?ex=65cfa201&is=65bd2d01&hm=39b0736e571e05307bdabd767512e4fd6c2700263172a6362e25ff7731020859&=&format=webp&quality=lossless&width=671&height=671',
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
