import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_card.dart';

class FavoritesPage extends StatelessWidget {
  final NewsController controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, left: 10.0, right: 10.0), // ✅ padding ke seluruh body
          child: controller.favoriteArticles.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No favorites yet',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add articles to your favorites to see them here.',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero, // ✅ biar gak dobel padding
                  itemCount: controller.favoriteArticles.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      article: controller.favoriteArticles[index],
                      showFavoriteButton: true,
                    );
                  },
                ),
        );
      }),
    );
  }

  void _showClearAllDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Delete All Favorites'),
        content: Text('Are you sure you want to delete all favorite articles?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Batal')),
          TextButton(
            onPressed: () {
              controller.favoriteArticles.clear();
              Get.back();
              Get.snackbar(
                'Favorit',
                'Semua favorit telah dihapus',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
