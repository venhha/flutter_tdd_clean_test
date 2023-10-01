import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/widgets/custom_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.article,
  });

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Row(
              children: [
                UrlImageWithCache(
                  url: article.urlToImage ?? '',
                  width: 100,
                  height: 100,
                ),
                // CachedNetworkImage(
                //   height: 100,
                //   width: 100,
                //   imageUrl: article.urlToImage ?? '',
                //   placeholder: (context, url) =>
                //       const CircularProgressIndicator(),
                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                // ),

                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(article.title ?? ''),
                        subtitle: Text(article.description ?? ''),
                      ),
                      ListTile(
                        title: Text(article.author ?? ''),
                        subtitle: Text(article.publishedAt ?? ''),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
