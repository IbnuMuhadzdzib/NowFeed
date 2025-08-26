import 'package:flutter/material.dart';
import 'package:flutter_application_7/controllers/theme_controller.dart';
import 'package:flutter_application_7/controllers/news_controller.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'search_page.dart';
import 'notif_page.dart';
import 'discover_page.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _pages = [
    HomePage(),
    DiscoverPage(),
    FavoritesPage(),
    SearchPage(),
    NotificationPage(),
  ];

  final NewsController newsController = Get.put(NewsController());
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() {
        return IndexedStack(
        index: newsController.selectedIndex.value,
        children: _pages,
      );
    }),
     floatingActionButton: Obx(() {
          bool isHome = newsController.selectedIndex.value == 0;
          return Transform.translate(
            offset: Offset(10, 0), // 🔽 turunin 10px
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                newsController.selectedIndex.value = 0;
              },
              child: Icon(
                Icons.home,
                color: isHome
                    ? Colors.white
                    : const Color.fromARGB(255, 222, 222, 222),
              ),
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // 📌 Custom Rounded Bottom NavBar
       bottomNavigationBar: Obx(() {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: 25), // ✅ kasih jarak bawah biar floating
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30), // ✅ rounded
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 12, // ✅ lebih lembut bayangannya
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Explore
        GestureDetector(
          onTap: () => newsController.selectedIndex.value = 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.explore,
                color: newsController.selectedIndex.value == 1
                    ? Theme.of(context).colorScheme.primary
                    : const Color.fromARGB(255, 71, 70, 70),
              ),
              Text(
                "Discover",
                style: TextStyle(
                  fontSize: 12,
                  color: newsController.selectedIndex.value == 1
                      ? Theme.of(context).colorScheme.primary
                      : const Color.fromARGB(255, 71, 70, 70),
                ),
              ),
            ],
          ),
        ),

        // Bookmark
        GestureDetector(
          onTap: () {
            newsController.selectedIndex.value = 2;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bookmark,
                color: newsController.selectedIndex.value == 2
                    ? Theme.of(context).colorScheme.primary
                    : const Color.fromARGB(255, 71, 70, 70),
              ),
              Text(
                "Favorites",
                style: TextStyle(
                  fontSize: 12,
                  color: newsController.selectedIndex.value == 2
                      ? Theme.of(context).colorScheme.primary
                      : const Color.fromARGB(255, 71, 70, 70),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 40), // space buat FAB

        // Search
        GestureDetector(
          onTap: () {
            newsController.selectedIndex.value = 3;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                color: newsController.selectedIndex.value == 3
                    ? Theme.of(context).colorScheme.primary
                    : const Color.fromARGB(255, 71, 70, 70),
              ),
              Text(
                "Search",
                style: TextStyle(
                  fontSize: 12,
                  color: newsController.selectedIndex.value == 3
                      ? Theme.of(context).colorScheme.primary
                      : const Color.fromARGB(255, 71, 70, 70),
                ),
              ),
            ],
          ),
        ),

        // Profile
        GestureDetector(
          onTap: () {
            newsController.selectedIndex.value = 4;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                color: newsController.selectedIndex.value == 4
                    ? Theme.of(context).colorScheme.primary
                    : const Color.fromARGB(255, 71, 70, 70),
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 12,
                  color: newsController.selectedIndex.value == 4
                      ? Theme.of(context).colorScheme.primary
                      : const Color.fromARGB(255, 71, 70, 70),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}),

    );
  }
}
