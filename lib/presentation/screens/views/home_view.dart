import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/theme.dart';
import 'package:reper/presentation/providers/auth/auth_repository_provider.dart';
import 'package:reper/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Tus Grupos'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CardTypeOne(),
                SizedBox(height: 15),
                CardTypeOne(),
                SizedBox(height: 15),
                CardTypeOne(),
                SizedBox(height: 15),
                FilledButton(
                  onPressed: () {
                    context.push('/create-group');
                  },
                  child: Text('Agregar Grupo'),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
