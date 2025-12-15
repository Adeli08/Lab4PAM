import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// A network image widget that falls back to Image.network if caching fails
class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return _CachedImageWrapper(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }
}

class _CachedImageWrapper extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const _CachedImageWrapper({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<_CachedImageWrapper> createState() => _CachedImageWrapperState();
}

class _CachedImageWrapperState extends State<_CachedImageWrapper> {
  bool _useFallback = false;

  @override
  Widget build(BuildContext context) {
    if (_useFallback) {
      // Fallback to Image.network if caching fails
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Image.network(
          widget.imageUrl,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return widget.placeholder ??
                Container(
                  width: widget.width,
                  height: widget.height,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          },
          errorBuilder: (context, error, stackTrace) {
            return widget.errorWidget ??
                Container(
                  width: widget.width,
                  height: widget.height,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error_outline, color: Colors.grey),
                );
          },
        ),
      );
    }

    // Try CachedNetworkImage first
    // Check if width/height are finite before converting to int
    final maxWidth = widget.width != null && widget.width!.isFinite
        ? (widget.width! * 2).toInt()
        : null;
    final maxHeight = widget.height != null && widget.height!.isFinite
        ? (widget.height! * 2).toInt()
        : null;
    
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      maxWidthDiskCache: maxWidth,
      maxHeightDiskCache: maxHeight,
      placeholder: (context, url) {
        return widget.placeholder ??
            Container(
              width: widget.width,
              height: widget.height,
              color: Colors.grey[300],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
      },
      errorWidget: (context, url, error) {
        // If it's a MissingPluginException, switch to fallback
        if (error.toString().contains('MissingPluginException') ||
            error.toString().contains('path_provider')) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _useFallback = true;
              });
            }
          });
          return widget.placeholder ??
              Container(
                width: widget.width,
                height: widget.height,
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
        }
        return widget.errorWidget ??
            Container(
              width: widget.width,
              height: widget.height,
              color: Colors.grey[300],
              child: const Icon(Icons.error_outline, color: Colors.grey),
            );
      },
    );
  }
}
