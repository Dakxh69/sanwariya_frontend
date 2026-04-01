import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isLarge;

  const ProductCard({
    super.key,
    required this.product,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.push('/product/${product.id}', extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest, // The layer principle
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 40,
              offset: const Offset(0, 4),
            ),
          ],
        ),
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        'NEW ARRIVAL',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
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
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
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
