import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/news_card.dart';
import '../widgets/category_chips.dart';
// import 'search_page.dart';
// import 'favorites_page.dart';

class HomePage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody:
            true, // ✅ penting biar body extend sampai belakang bottom nav
        backgroundColor: themeController.isDarkMode.value
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.onTertiary,

        appBar: AppBar(
          title: Text('NowFeed'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          actions: [
            IconButton(icon: Icon(Icons.sort), onPressed: () {}),
            Obx(() {
              return IconButton(
                icon: Icon(
                  themeController.isDarkMode.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  themeController.toggleTheme();
                },
              );
            }),
          ],
        ),

        body: Column(
          children: [
            CategoryChips(),
            Expanded(
              child: Obx(() {
                if (newsController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (newsController.errorMessage.isNotEmpty) {
                  return Center(child: Text(newsController.errorMessage.value));
                }
                if (newsController.articles.isEmpty) {
                  return Center(child: Text('Tidak ada berita tersedia'));
                }
                return RefreshIndicator(
                  onRefresh: () async => newsController.refreshNews(),
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: newsController.articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(article: newsController.articles[index]);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
