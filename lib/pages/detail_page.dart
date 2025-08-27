import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';
import '../controllers/news_controller.dart';

class DetailPage extends StatelessWidget {
  final Article article;
  final NewsController controller = Get.find<NewsController>();

  DetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(  context).colorScheme.primary,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isFavorite(article)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: controller.isFavorite(article) ? Theme.of(context).colorScheme.onPrimary : Colors.black87,
              ),
              onPressed: () => controller.toggleFavorite(article),
            ),
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.black87),
            onPressed: () => _shareArticle(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            if (article.urlToImage.isNotEmpty)
              Hero(
                tag: article.url,
                child: Container(
                  width: double.infinity,
                  height: 240,
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(Icons.image_not_supported,
                              size: 64, color: Colors.grey[600]),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),

            // Content
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 12),

                  // Meta Info
                  Row(
                    children: [
                      Icon(Icons.source, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.source,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  if (article.author.isNotEmpty &&
                      article.author != 'Unknown Author')
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Icon(Icons.person,
                              size: 16, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            'By ${article.author}',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 18),
                  Divider(),
                  SizedBox(height: 18),

                  // Description
                  Text(
                    article.description,
                    style: TextStyle(fontSize: 16, height: 1.6),
                  ),
                  SizedBox(height: 16),

                  // Content (if exists and different)
                  if (article.content.isNotEmpty &&
                      article.content != article.description)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Content:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text(
                          article.content,
                          style: TextStyle(fontSize: 16, height: 1.6),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),

                  // Read More button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(article.url),
                      icon: Icon(Icons.open_in_browser),
                      label: Text('Read Full Article'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
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
      List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _launchURL(String url) async {
    if (url.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Unable to open the link',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void _shareArticle() {
    // Ideally use share_plus package
    Get.snackbar(
      'Share',
      'Sharing feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
