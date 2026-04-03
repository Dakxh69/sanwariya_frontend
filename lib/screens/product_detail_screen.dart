import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/network_image.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/sanwariya_app_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedThumbnailIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = context.select<MockDataProvider, Product?>(
      (provider) => provider.products.firstWhere(
        (p) => p.id == widget.productId,
        orElse: () => provider.products.first,
      ),
    );

    if (product == null) {
      return Scaffold(
        appBar: const SanwariyaAppBar(currentPath: '/collection'),
        body: const Center(child: Text('Product not found.')),
      );
    }

    final thumbnails = [
      product.imageUrl,
      'https://lh3.googleusercontent.com/aida-public/AB6AXuA0fTIWq1iSpjL-hPT_uYN7WJt1tI3dlILM_slYLFl6fzWqTHKyj6iZCUSbkfDmhvtcd6Sily2nSqCHfYOnGoN51sy2QW-PiBh0ebfI8autP-Jp7yAlNat5YSPiR5p_WaVb2bR6bXaCwHPqBDsCSdclCef-Bk8Hk0RYT4rVebejmf-OT5-8-rYQbGb9UAajA9Je0oIXk-pPTebcXzKnK3OhGChBNAy7gLLQKpC7zdIix3VbE5DbnN4U1pMKwTv8pz1U8PZdRAJxNJaN',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBSgBQRY-3iFs8glaeIZMFJHGk9deimfY_Iy1dwYZbJFtz11Gzr73R9oK8OR9qo5Tf-MovJZQ9lkQvC8PGpoEsxRViOnBlIarkJO8QIhBZWT8zkaZ2w5sINltCsq78AThjjpxvEQrhK6p_4e2MrR7FZaky-nbL_EgzotD5rsVgl3DG3RlUn87DH2VrdZZn_6i4Y8EfG8nNBdJsNlkusq3u8G-PXcM5dpsIuJRu3FBnQVjKDaPcWJ2Az_iHfAVl-mctC-PRg7VMirWh0',
    ];

    final relatedProducts = context.select<MockDataProvider, List<Product>>(
      (provider) => provider.products
          .where(
            (p) => p.categoryId == product.categoryId && p.id != product.id,
          )
          .toList(),
    );

    return Scaffold(
      bottomNavigationBar: Responsive.showBottomNav(context)
          ? const GlassBottomNav(currentPath: '/detail')
          : null,
      backgroundColor: AppTheme.background,
      appBar: const SanwariyaAppBar(currentPath: '/collection'),
      body: Responsive.isDesktop(context)
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 40,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AestheticNetworkImage(
                                  imageUrl: thumbnails[_selectedThumbnailIndex],
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.zero,
                                ),
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.surfaceContainer
                                              .withValues(alpha: 0.6),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.threesixty,
                                              size: 16,
                                              color: AppTheme.onSurface,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '360° View',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color: AppTheme.onSurface,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: thumbnails.length,
                              separatorBuilder: (_, i) =>
                                  const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final isActive =
                                    index == _selectedThumbnailIndex;
                                return GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedThumbnailIndex = index,
                                  ),
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isActive
                                            ? AppTheme.primary
                                            : AppTheme.outlineVariant
                                                  .withValues(alpha: 0.3),
                                        width: isActive ? 2 : 1,
                                      ),
                                    ),
                                    child: Opacity(
                                      opacity: isActive ? 1.0 : 0.6,
                                      child: AestheticNetworkImage(
                                        imageUrl: thumbnails[index],
                                        fit: BoxFit.cover,
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 64),

                    Expanded(
                      flex: 4,
                      child: _buildProductInfo(
                        context,
                        product,
                        relatedProducts,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AestheticNetworkImage(
                            imageUrl: thumbnails[_selectedThumbnailIndex],
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.zero,
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceContainer.withValues(
                                      alpha: 0.6,
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.threesixty,
                                        size: 16,
                                        color: AppTheme.onSurface,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '360° View',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: AppTheme.onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: thumbnails.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final isActive = index == _selectedThumbnailIndex;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedThumbnailIndex = index),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isActive
                                    ? AppTheme.primary
                                    : AppTheme.outlineVariant.withValues(
                                        alpha: 0.3,
                                      ),
                                width: isActive ? 2 : 1,
                              ),
                            ),
                            child: Opacity(
                              opacity: isActive ? 1.0 : 0.6,
                              child: AestheticNetworkImage(
                                imageUrl: thumbnails[index],
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  _buildProductInfo(context, product, relatedProducts),
                ],
              ),
            ),
    );
  }

  Widget _buildProductInfo(
    BuildContext context,
    Product product,
    List<Product> relatedProducts,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(
                4,
                (_) =>
                    const Icon(Icons.star, color: AppTheme.primary, size: 20),
              ),
              const Icon(Icons.star, color: AppTheme.outlineVariant, size: 20),
              const SizedBox(width: 8),
              Text(
                '(33 reviews)',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.outlineVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '₹${(product.price * 1.1).toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withValues(alpha: 0.6),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            product.description,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color.fromARGB(255, 255, 255, 255),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              border: Border.all(
                color: AppTheme.outlineVariant.withValues(alpha: 0.12),
                width: 0.6,
              ),
            ),
            child: Column(
              children: [
                _buildSpecRow('Gold Purity:', '22K'),
                const SizedBox(height: 16),
                _buildSpecRow('Weight:', '15g'),
                const SizedBox(height: 16),
                _buildSpecRow('SKU:', 'AK-001'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Availability:',
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                      ),
                    ),
                    Text(
                      '9 in stock',
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Text(
                'Quantity:',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_quantity > 1) setState(() => _quantity--);
                      },
                      icon: const Icon(Icons.remove, color: AppTheme.onSurface),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          vertical: BorderSide(
                            color: AppTheme.outlineVariant.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        _quantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => _quantity++),
                      icon: const Icon(Icons.add, color: AppTheme.onSurface),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.read<MockDataProvider>().addToCart(
                product,
                quantity: _quantity,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF2F2F2),
              foregroundColor: Colors.black,
              elevation: 0,
              minimumSize: const Size.fromHeight(62),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart_outlined, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Add to Cart',
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              context.read<MockDataProvider>().addToCart(
                product,
                quantity: _quantity,
              );
              context.push('/cart');
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF2E270F),
              side: const BorderSide(color: AppTheme.primary, width: 1),
              minimumSize: const Size.fromHeight(62),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppTheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  'Buy Now',
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppTheme.surfaceContainerLowest,
                    side: const BorderSide(color: AppTheme.primary, width: 1),
                    minimumSize: const Size.fromHeight(56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  icon: const Icon(
                    Icons.favorite_border,
                    color: AppTheme.onSurface,
                  ),
                  label: Text(
                    'Wishlist',
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                            color: AppTheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppTheme.surfaceContainerLowest,
                    side: const BorderSide(color: AppTheme.primary, width: 1),
                    minimumSize: const Size.fromHeight(56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  icon: const Icon(
                    Icons.share_outlined,
                    color: AppTheme.onSurface,
                  ),
                  label: Text(
                    'Share',
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                            color: AppTheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (relatedProducts.isNotEmpty) ...[
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    'You May Also Like',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppTheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Similar products from ${product.category}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: AppTheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              itemCount: relatedProducts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final related = relatedProducts[index];
                return _RelatedProductListItem(product: related);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            textStyle: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: Colors.white),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _RelatedProductListItem extends StatelessWidget {
  final Product product;

  const _RelatedProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const discountPercent = 10;
    final mrp =
        '₹${(product.price / (1 - (discountPercent / 100))).toStringAsFixed(0)}';
    final price = '₹${product.price.toStringAsFixed(0)}';
    final category = product.category.toUpperCase();
    final metaLabel = product.isBestSeller
        ? 'Best Seller'
        : (product.isNewArrival ? 'New Arrival' : 'Handcrafted');

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow,
          border: Border.all(
            color: AppTheme.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: Responsive.isDesktop(context) ? 16 / 8 : 4 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: AppTheme.surfaceContainerLowest,
                    child: AestheticNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      color: AppTheme.primary,
                      child: Text(
                        '$discountPercent% OFF',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppTheme.onPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              category,
              style: GoogleFonts.inter(
                textStyle: textTheme.labelSmall,
                color: AppTheme.primary,
                letterSpacing: 1,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              product.name,
              style: GoogleFonts.playfairDisplay(
                textStyle: textTheme.headlineSmall?.copyWith(
                  color: AppTheme.onSurface,
                  height: 1.15,
                ),
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  price,
                  style: textTheme.headlineMedium?.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  mrp,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppTheme.outline,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  metaLabel,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppTheme.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'In Stock',
                  style: GoogleFonts.inter(
                    textStyle: textTheme.labelSmall,
                    color: const Color(0xFF32F58A),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
