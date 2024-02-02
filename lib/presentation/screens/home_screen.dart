import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/screens/screens.dart';

import 'package:reper/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {

  late PageController pageController;
  final viewRoutes = const <Widget>[
    HomeView(),
    AlbumsView(),
    NotificationsView(),
    ProfileView()
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(widget.pageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    }
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
