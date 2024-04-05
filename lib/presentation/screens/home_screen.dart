import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    SocialView(),
    LibraryView(),
    ProfileView()
  ];

  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).streamUserInfo(_auth.currentUser!.uid);
    ref.read(userSongsListProvider.notifier).streamUserSongs(_auth.currentUser!.uid);
    ref.read(userNotificationListProvider.notifier).streamUserNotifications();
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
    return Stack(
      children: [
        Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: viewRoutes,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: widget.pageIndex,
          ),
        ),
        _buildValidateIfNeedsToUpdate()
      ],
    );
  }

   Widget _buildValidateIfNeedsToUpdate() {
    return StreamBuilder(
      stream: ref.watch(appDataRepositoryProvider).streamAppData(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return const SizedBox();
        }

        final latestVersion = data.version;

        return FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data == null) {
              return const SizedBox();
            }

            final currentVersion = data.version;
            print('CURRENT VERSION: $currentVersion');


            if (currentVersion.compareTo(latestVersion) < 0) {
              return const UpdateView();
            }
            return const SizedBox();
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
