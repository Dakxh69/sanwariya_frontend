import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isLarge;

  const ProductCard({super.key, required this.product, this.isLarge = false});

  static const _cardDecoration = BoxDecoration(
    color: AppTheme.surfaceContainerLowest,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [
      BoxShadow(color: Color(0x0D000000), blurRadius: 40, offset: Offset(0, 4)),
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
                    style: isLarge
                        ? textTheme.displaySmall
                        : textTheme.titleMedium,
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
