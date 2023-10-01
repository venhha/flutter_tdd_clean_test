import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UrlImage extends StatelessWidget {
  final double height;
  final double width;
  final String url;

  const UrlImage({
    super.key,
    required this.height,
    required this.width,
    required this.url,
  });

  Future<bool> canDisplayImage() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: canDisplayImage(),
      builder: (context, snapshot) {
        // snapshot.hasData && snapshot.data == true
        if (snapshot.hasData && snapshot.data!) {
          return Image.network(url, height: height, width: width);
        } else if (snapshot.hasData && snapshot.data == false) {
          return const Icon(Icons.error);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class UrlImageWithCache extends StatelessWidget {
  final double height;
  final double width;
  final String url;

  const UrlImageWithCache({
    super.key,
    required this.height,
    required this.width,
    required this.url,
  });

  Future<bool> canDisplayImage() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: canDisplayImage(),
      builder: (context, snapshot) {
        // snapshot.hasData && snapshot.data == true
        if (snapshot.hasData && snapshot.data!) {
          return CachedNetworkImage(
            height: 100,
            width: 100,
            imageUrl: url,
            cacheKey: url,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        } else if (snapshot.hasData && snapshot.data == false) {
          return const Icon(Icons.error);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
