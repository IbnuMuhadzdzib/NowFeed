import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/news_card.dart';
import '../widgets/category_chips.dart';
// import 'search_page.dart';
// import 'favorites_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

body: Obx(() {
  if (newsController.isLoading.value) {
    return Center(child: CircularProgressIndicator());
  }
  if (newsController.errorMessage.isNotEmpty) {
    return Center(child: Text(newsController.errorMessage.value));
  }
  if (newsController.articles.isEmpty) {
    return Center(child: Text('No articles found.'));
  }

  final hotNews = newsController.articles.take(5).toList();

  return RefreshIndicator(
    onRefresh: () async => newsController.refreshNews(),
    child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ✅ Category Chips
        CategoryChips(),

        SizedBox(height: 12),

        // ✅ Carousel hot news
        // ✅ Carousel hot news
if (hotNews.isNotEmpty)
  Container(
    margin: EdgeInsets.only(bottom: 24), // kasih jarak bawah
    child: CarouselSlider.builder(
      itemCount: hotNews.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.70,
        aspectRatio: 16 / 9,
      ),
      itemBuilder: (context, index, realIndex) {
        final article = hotNews[index];
        return GestureDetector(
          onTap: () {
            // Get.to(() => DetailPage(article: article));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(article.urlToImage ??
                    "https://via.placeholder.com/400x200.png?text=No+Image"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.all(12),
              alignment: Alignment.bottomLeft,
              child: Text(
                article.title ?? "No Title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    ),
  ),

        SizedBox(height: 20),

        // ✅ Daftar berita lain
        ...newsController.articles.map((article) => NewsCard(article: article)),
      ],
    ),
  );
}),
      );
    });
  }
}
