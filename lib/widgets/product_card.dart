import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'network_image.dart';

/// **Optimization Log:**
/// 1. `_cardDecoration` is a `static const` field. `BoxDecoration` containing
///    a `BoxShadow` was previously rebuilt on every `build()` call.
///    A const field means a single allocation at class-load time, shared
///    across all `ProductCard` instances.
/// 2. `const ProductCard(...)` is supported because all fields are final —
///    parent widgets can use `const` constructors to get build-cache hits
///    when the product reference doesn't change.
class ProductCard extends StatelessWidget {
  final Product product;
  final bool isLarge;

  const ProductCard({
    super.key,
    required this.product,
    this.isLarge = false,
  });

  // Shared constant decoration — one allocation for all cards.
  static const _cardDecoration = BoxDecoration(
    color: AppTheme.surfaceContainerLowest,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [
      BoxShadow(
        color: Color(0x0D000000), // onSurface @ ~5% alpha — const-safe
        blurRadius: 40,
        offset: Offset(0, 4),
      ),
    ],
  );

  static const _imageRadius = BorderRadius.vertical(top: Radius.circular(8.0));

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}', extra: product),
      child: Container(
        decoration: _cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: AestheticNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  borderRadius: _imageRadius,
                ),
              ),
            ),
            // Details Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.isNewArrival)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: _NewArrivalBadge(),
                    ),
                  Text(
                    product.name,
                    style: isLarge ? textTheme.displaySmall : textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
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

/// Extracted as a `const` widget so it is built once and shared from the
/// element cache — never rebuilt by parent state changes.
class _NewArrivalBadge extends StatelessWidget {
  const _NewArrivalBadge();

  @override
  Widget build(BuildContext context) {
    return Text(
      'NEW ARRIVAL',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
    );
  }
}
