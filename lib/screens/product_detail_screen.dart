import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/network_image.dart';
import '../widgets/glass_bottom_nav.dart';

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
    // API_HOOK: Replace with GET /api/products/:id — fetch single product by ID from Firestore/backend
    final product = context.select<MockDataProvider, Product?>(
      (provider) => provider.products.firstWhere(
        (p) => p.id == widget.productId,
        orElse: () => provider.products.first,
      ),
    );

    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Product not found.')),
      );
    }

    final thumbnails = [
      product.imageUrl,
      'https://lh3.googleusercontent.com/aida-public/AB6AXuA0fTIWq1iSpjL-hPT_uYN7WJt1tI3dlILM_slYLFl6fzWqTHKyj6iZCUSbkfDmhvtcd6Sily2nSqCHfYOnGoN51sy2QW-PiBh0ebfI8autP-Jp7yAlNat5YSPiR5p_WaVb2bR6bXaCwHPqBDsCSdclCef-Bk8Hk0RYT4rVebejmf-OT5-8-rYQbGb9UAajA9Je0oIXk-pPTebcXzKnK3OhGChBNAy7gLLQKpC7zdIix3VbE5DbnN4U1pMKwTv8pz1U8PZdRAJxNJaN',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBSgBQRY-3iFs8glaeIZMFJHGk9deimfY_Iy1dwYZbJFtz11Gzr73R9oK8OR9qo5Tf-MovJZQ9lkQvC8PGpoEsxRViOnBlIarkJO8QIhBZWT8zkaZ2w5sINltCsq78AThjjpxvEQrhK6p_4e2MrR7FZaky-nbL_EgzotD5rsVgl3DG3RlUn87DH2VrdZZn_6i4Y8EfG8nNBdJsNlkusq3u8G-PXcM5dpsIuJRu3FBnQVjKDaPcWJ2Az_iHfAVl-mctC-PRg7VMirWh0',
    ];

    return Scaffold(
      bottomNavigationBar: Responsive.showBottomNav(context)
          ? const GlassBottomNav(currentPath: '/detail')
          : null,
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Column(
          children: [
            Text(
              'Sanwariya',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.primary,
                    letterSpacing: 1.5,
                    fontFamily: 'Noto Serif',
                  ),
            ),
            Text(
              'Imitation',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.onSurface,
                    fontFamily: 'Noto Serif',
                  ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => context.push('/cart'),
              ),
              Consumer<MockDataProvider>(
                builder: (context, provider, child) {
                  if (provider.cartCount == 0) return const SizedBox.shrink();
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                      child: Text(
                        provider.cartCount.toString(),
                        style: const TextStyle(color: AppTheme.onPrimary, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Responsive.isDesktop(context)
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: image + thumbnails
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
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppTheme.surfaceContainer.withValues(alpha: 0.6),
                                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.threesixty, size: 16, color: AppTheme.onSurface),
                                            const SizedBox(width: 8),
                                            Text('360° View', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurface)),
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
                              separatorBuilder: (_, _a) => const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final isActive = index == _selectedThumbnailIndex;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedThumbnailIndex = index),
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isActive ? AppTheme.primary : AppTheme.outlineVariant.withValues(alpha: 0.3),
                                        width: isActive ? 2 : 1,
                                      ),
                                    ),
                                    child: Opacity(
                                      opacity: isActive ? 1.0 : 0.6,
                                      child: AestheticNetworkImage(imageUrl: thumbnails[index], fit: BoxFit.cover, borderRadius: BorderRadius.zero),
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
                    // Right: product info
                    Expanded(
                      flex: 4,
                      child: _buildProductInfo(context, product),
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
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceContainer.withValues(alpha: 0.6),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.threesixty, size: 16, color: AppTheme.onSurface),
                                      const SizedBox(width: 8),
                                      Text(
                                        '360° View',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurface),
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
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final isActive = index == _selectedThumbnailIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedThumbnailIndex = index),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isActive ? AppTheme.primary : AppTheme.outlineVariant.withValues(alpha: 0.3),
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
                  _buildProductInfo(context, product),
                ],
              ),
            ),
    );
  }

  Widget _buildProductInfo(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(4, (_) => const Icon(Icons.star, color: AppTheme.primary, size: 20)),
              const Icon(Icons.star, color: AppTheme.outlineVariant, size: 20),
              const SizedBox(width: 8),
              Text('(33 reviews)', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outlineVariant)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('₹${product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Text('₹${(product.price * 1.1).toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.outlineVariant.withValues(alpha: 0.6), decoration: TextDecoration.lineThrough)),
            ],
          ),
          const SizedBox(height: 24),
          Text(product.description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.onSurfaceVariant, height: 1.6)),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.surfaceContainerLowest, border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.1))),
            child: Column(
              children: [
                _buildSpecRow('Gold Purity:', '22K'),
                const SizedBox(height: 16),
                _buildSpecRow('Weight:', '15g'),
                const SizedBox(height: 16),
                _buildSpecRow('SKU:', 'AK-001'),
                const SizedBox(height: 16),
                const Divider(color: AppTheme.outlineVariant),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Availability:', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.onSurface.withValues(alpha: 0.7))),
                    Text('9 in stock', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Text('Quantity:', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(width: 24),
              Container(
                decoration: BoxDecoration(border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.3))),
                child: Row(
                  children: [
                    IconButton(onPressed: () { if (_quantity > 1) setState(() => _quantity--); }, icon: const Icon(Icons.remove, color: AppTheme.onSurface)),
                    Container(
                      width: 48, height: 48, alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.3)))),
                      child: Text(_quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    IconButton(onPressed: () => setState(() => _quantity++), icon: const Icon(Icons.add, color: AppTheme.onSurface)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.read<MockDataProvider>().addToCart(product, quantity: _quantity);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${product.name} added to cart'),
                behavior: SnackBarBehavior.floating,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                backgroundColor: AppTheme.primary,
                action: SnackBarAction(label: 'VIEW CART', textColor: AppTheme.onPrimary, onPressed: () => context.push('/cart')),
              ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(64), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 8),
                Text('ADD TO CART', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              context.read<MockDataProvider>().addToCart(product, quantity: _quantity);
              context.push('/cart');
            },
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.primary), minimumSize: const Size.fromHeight(64), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart, color: AppTheme.primary),
                const SizedBox(width: 8),
                Text('BUY NOW', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: OutlinedButton.icon(onPressed: () {}, style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.3)), minimumSize: const Size.fromHeight(56), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)), icon: const Icon(Icons.favorite_border, color: AppTheme.onSurface), label: Text('Wishlist', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.onSurface)))),
              const SizedBox(width: 16),
              Expanded(child: OutlinedButton.icon(onPressed: () {}, style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.3)), minimumSize: const Size.fromHeight(56), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)), icon: const Icon(Icons.share_outlined, color: AppTheme.onSurface), label: Text('Share', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.onSurface)))),
            ],
          ),
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
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurface.withValues(alpha: 0.7),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
