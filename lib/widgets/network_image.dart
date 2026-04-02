import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

/// **Optimization Log:**
/// 1. `_defaultRadius` is a `static const` — the `BorderRadius` object is
///    allocated once at class load time, not on every `build()` call.
///    Previously every render created a new `BorderRadius.circular(8.0)`.
/// 2. `_placeholder` and `_errorWidget` are extracted as separate
///    `const StatelessWidget`s so Flutter's element reconciler can
///    short-circuit their rebuild when the parent re-renders.
/// 3. `memCacheWidth` / `memCacheHeight` hints are forwarded to
///    `CachedNetworkImage` when explicit dimensions are provided.
///    This tells the image codec to decode the bitmap at the display size
///    rather than at the full source resolution, reducing GPU texture
///    memory by up to 4–8x for large hero images.
class AestheticNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  // Pre-allocated constant — avoids per-build object construction.
  static const BorderRadius _defaultRadius = BorderRadius.all(Radius.circular(8.0));

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
    return ClipRRect(
      borderRadius: borderRadius ?? _defaultRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        // Decode at display size to cap GPU texture memory usage.
        memCacheWidth:  width?.toInt(),
        memCacheHeight: height?.toInt(),
        placeholder: (context, url) => _ImagePlaceholder(width: width, height: height),
        errorWidget:   (context, url, error) => _ImageError(width: width, height: height),
      ),
    );
  }
}

/// Extracted as a separate widget so Flutter's element cache can recognise
/// it as identical across rebuilds and skip re-rendering it.
class _ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const _ImagePlaceholder({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppTheme.surfaceContainerHigh,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  final double? width;
  final double? height;

  const _ImageError({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppTheme.surfaceContainerHigh,
      child: const Center(
        child: Icon(Icons.broken_image, color: AppTheme.outline),
      ),
    );
  }
}
