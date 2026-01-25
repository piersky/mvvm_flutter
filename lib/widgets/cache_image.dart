import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mvv_managements/constants/app_icons.dart';

class CachedImageWidget extends StatelessWidget {
  CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.imgHeight,
    this.imgWidth,
    this.boxFit,
  });

  final String imageUrl;
  final double? imgHeight;
  final double? imgWidth;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CachedNetworkImage(
      width: imgWidth ?? size.width * 0.2,
      fit: boxFit ?? BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          const Icon(AppIcons.error, color: Colors.red),
    );
  }
}
