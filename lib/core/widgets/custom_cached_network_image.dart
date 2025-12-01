import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCachedNetworkImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const CustomCachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.height,
    this.width,
    this.hasLoading = true,
  });

  final String imageUrl;
  final String? placeholder;
  final bool hasLoading;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: BoxFit.fill,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) =>
          Skeletonizer(enabled: true, child: Icon(Icons.image, size: width ?? 50)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
