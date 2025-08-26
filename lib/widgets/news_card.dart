import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/article.dart';
import '../controllers/news_controller.dart';
import '../pages/detail_page.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final bool showFavoriteButton;
  final NewsController controller = Get.find<NewsController>();

  NewsCard({required this.article, this.showFavoriteButton = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      elevation: 6, // ✨ shadow lebih modern
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () => Get.to(() => DetailPage(article: article)),
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====================== GAMBAR ======================
            if (article.urlToImage.isNotEmpty)
              Hero(
                tag: article.url,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        article.urlToImage,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      // ✨ Overlay gradient agar teks/fav lebih jelas
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),

                      // ====================== FAVORITE BUTTON ======================
                      if (showFavoriteButton)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Obx(
                            () => GestureDetector(
                              onTap: () => controller.toggleFavorite(article),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  controller.isFavorite(article)
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  color: controller.isFavorite(article)
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey[700],
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            // ====================== CONTENT ======================
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ====================== TITLE ======================
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),

                  // ====================== DESCRIPTION ======================
                  Text(
                    article.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.7),
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 14),

                  // ====================== META INFO (Source + Time) ======================
                  Row(
                    children: [
                      Icon(Icons.public, size: 14, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.source,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        _formatDate(article.publishedAt), // ✨ WAKTU
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }
}
