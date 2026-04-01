import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class AestheticNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AestheticNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(8.0); // lg (0.5rem) from Stitch

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: AppTheme.surfaceContainerHigh,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppTheme.surfaceContainerHigh,
          child: const Center(
            child: Icon(Icons.broken_image, color: AppTheme.outline),
          ),
        ),
      ),
    );
  }
}
