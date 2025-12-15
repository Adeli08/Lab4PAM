import 'package:flutter/material.dart';
import 'network_image_with_fallback.dart';
import '../../domain/entities/news_item.dart';

class NewsItemWidget extends StatelessWidget {
  final NewsItem newsItem;

  const NewsItemWidget({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
              children: [
                ClipOval(
                  child: NetworkImageWithFallback(
                    imageUrl: newsItem.publisherIcon,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    placeholder: Container(
                      width: 30,
                      height: 30,
                      color: Colors.grey[300],
                      child: const Center(
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: Container(
                      width: 30,
                      height: 30,
                      color: Colors.grey[300],
                      child: const Icon(Icons.business, size: 15, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  newsItem.publisher,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (newsItem.isVerified) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.verified, color: Colors.blue, size: 16),
                ],
                const Spacer(),
                Text(
                  newsItem.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (newsItem.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: NetworkImageWithFallback(
                  imageUrl: newsItem.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.grey, size: 48),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load image',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              newsItem.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                newsItem.category,
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 12,
                ),
              ),
            ),
            if (newsItem.isFollowing != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        newsItem.isFollowing! ? 'Following' : 'Follow',
                        style: TextStyle(
                          color: newsItem.isFollowing! ? Colors.green : Colors.blue,
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
}