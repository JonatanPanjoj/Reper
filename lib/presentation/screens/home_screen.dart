import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reper/presentation/providers/loaders/initial_loading_provider.dart';
import 'package:reper/presentation/providers/providers.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  late PageController pageController;
  final viewRoutes = const <Widget>[
    HomeView(),
    AlbumsView(),
    LibraryView(),
    ProfileView()
  ];

  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).streamUserInfo(_auth.currentUser!.uid);
    ref.read(userSongsListProvider.notifier).streamUserSongs(_auth.currentUser!.uid);
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

    final isLoading = ref.watch(initialLoadingProvider);
    if (isLoading) return const FullScreenLoader();

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
