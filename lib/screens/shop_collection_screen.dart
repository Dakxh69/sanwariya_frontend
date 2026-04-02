import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/network_image.dart';
import '../widgets/nav_menu.dart';
import '../widgets/glass_bottom_nav.dart';

/// **Optimization Log — Screen level:**
/// 1. `context.select` instead of `context.watch` — the screen now subscribes
///    ONLY to `provider.products`. Cart mutations (add/remove) no longer trigger
///    a full screen rebuild; only the `_CartBadge` Consumer handles those.
/// 2. `_filteredProducts()` is NO LONGER called inside `build()`. Instead the
///    filter result is cached in `_cachedFiltered` and recomputed only inside
///    `setState()` calls (i.e. when the actual filter criteria change). This
///    eliminates repeated sort+filter on every frame / layout pass.
/// 3. `_buildProductCard` has been replaced by the `_ProductCardItem` widget
///    class. Sliver delegates now get a properly keyed, separately typed widget
///    so Flutter's element reconciler can skip unchanged cards during rebuilds.
class ShopCollectionScreen extends StatefulWidget {
  const ShopCollectionScreen({super.key});

  @override
  State<ShopCollectionScreen> createState() => _ShopCollectionScreenState();
}

class _ShopCollectionScreenState extends State<ShopCollectionScreen> {
  bool _showFilters = false;
  String _selectedCategory = 'All';
  String? _selectedPurity;
  final TextEditingController _minPriceCtrl = TextEditingController();
  final TextEditingController _maxPriceCtrl = TextEditingController();
  String _sortOrder = 'Newest First';

  // Cached filter result — recomputed only on explicit filter changes,
  // not on every build() call.
  List<Product> _cachedFiltered = const [];

  static const _categories = ['All', 'Bangles', 'Bracelets', 'Chains', 'Earrings', 'Necklaces', 'Pendants', 'Rings'];
  static const _purities   = ['0K', '18K', '22K', '24K'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initial population after the first dependency injection.
    _updateFilter();
  }

  @override
  void dispose() {
    _minPriceCtrl.dispose();
    _maxPriceCtrl.dispose();
    super.dispose();
  }

  /// Recomputes `_cachedFiltered` from current filter state + latest product list.
  /// Called inside every `setState` that mutates a filter criterion, and once
  /// on `didChangeDependencies` for the initial render.
  void _updateFilter() {
    final products = context.read<MockDataProvider>().products;
    var result = products.where((p) {
      final catMatch = _selectedCategory == 'All' ||
          p.category.toLowerCase() == _selectedCategory.toLowerCase();
      final minPrice = double.tryParse(_minPriceCtrl.text);
      final maxPrice = double.tryParse(_maxPriceCtrl.text);
      final minMatch = minPrice == null || p.price >= minPrice;
      final maxMatch = maxPrice == null || p.price <= maxPrice;
      return catMatch && minMatch && maxMatch;
    }).toList();

    if (_sortOrder == 'Price: Low to High') result.sort((a, b) => a.price.compareTo(b.price));
    if (_sortOrder == 'Price: High to Low') result.sort((a, b) => b.price.compareTo(a.price));

    _cachedFiltered = result;
  }

  void _clearFilters() {
    _minPriceCtrl.clear();
    _maxPriceCtrl.clear();
    setState(() {
      _selectedCategory = 'All';
      _selectedPurity   = null;
      _updateFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    // context.select: rebuilds ONLY when the products list identity changes.
    // Cart mutations (cartCount, cartTotal) no longer rebuild this screen.
    context.select<MockDataProvider, List<Product>>((p) => p.products);

    final showBottom = Responsive.showBottomNav(context);
    final isDesktop  = Responsive.isDesktop(context);
    final hPad       = Responsive.horizontalPadding(context);
    final products   = _cachedFiltered;

    return Scaffold(
      bottomNavigationBar: showBottom ? const GlassBottomNav(currentPath: '/collection') : null,
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(
          'SANWARIYA',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primary,
                letterSpacing: 3.0,
                fontFamily: 'Noto Serif',
              ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => context.push('/cart'),
              ),
              // _CartBadge is a fine-grained Consumer — only this widget
              // rebuilds when cartCount changes.
              const _CartBadge(),
            ],
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => NavMenu.show(context, currentPath: '/collection'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: hPad.copyWith(top: 48, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shop Collection',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Discover our exquisite range of handcrafted jewelry',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 32),

                  // Toggle Filter Button
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _showFilters = !_showFilters;
                    }),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      backgroundColor: _showFilters ? AppTheme.primary : Colors.transparent,
                      side: const BorderSide(color: AppTheme.primary),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    icon: Icon(Icons.filter_list, color: _showFilters ? AppTheme.onPrimary : AppTheme.primary),
                    label: Text(
                      _showFilters ? 'HIDE FILTERS' : 'SHOW FILTERS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _showFilters ? AppTheme.onPrimary : AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                    ),
                  ),

                  // Filter Panel
                  if (_showFilters) ...[
                    const SizedBox(height: 24),
                    Container(
                      color: AppTheme.surfaceContainerLow,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Categories', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          ..._categories.map((cat) => _FilterOption(
                                label: cat,
                                isSelected: _selectedCategory == cat,
                                onTap: () => setState(() {
                                  _selectedCategory = cat;
                                  _updateFilter();
                                }),
                              )),

                          const SizedBox(height: 24),
                          Container(height: 1, color: AppTheme.outlineVariant),
                          const SizedBox(height: 24),

                          Text('Gold Purity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          ..._purities.map((p) => _FilterOption(
                                label: p,
                                isSelected: _selectedPurity == p,
                                onTap: () => setState(() {
                                  _selectedPurity = _selectedPurity == p ? null : p;
                                  _updateFilter();
                                }),
                              )),

                          const SizedBox(height: 24),
                          Container(height: 1, color: AppTheme.outlineVariant),
                          const SizedBox(height: 24),

                          Text('Price Range', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _PriceField(
                            controller: _minPriceCtrl,
                            hint: 'Min Price',
                            onChanged: (_) => setState(_updateFilter),
                          ),
                          const SizedBox(height: 12),
                          _PriceField(
                            controller: _maxPriceCtrl,
                            hint: 'Max Price',
                            onChanged: (_) => setState(_updateFilter),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: _clearFilters,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: const BorderSide(color: AppTheme.primary),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                              ),
                              child: Text(
                                'Clear Filters',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${products.length} products found',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurface),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          border: Border.all(color: AppTheme.outlineVariant),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _sortOrder,
                            icon: const Icon(Icons.expand_more, color: AppTheme.outline),
                            dropdownColor: AppTheme.surfaceContainerHigh,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurface),
                            items: ['Newest First', 'Price: Low to High', 'Price: High to Low', 'Best Selling']
                                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                                .toList(),
                            onChanged: (v) => setState(() {
                              _sortOrder = v ?? _sortOrder;
                              _updateFilter();
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: hPad.copyWith(top: 16, bottom: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.gridCrossAxisCount(context),
                childAspectRatio: isDesktop ? 0.65 : 0.55,
                mainAxisSpacing: 32,
                crossAxisSpacing: isDesktop ? 24 : 16,
              ),
              delegate: SliverChildBuilderDelegate(
                // _ProductCardItem is a keyed, separate widget class so Flutter
                // can skip rebuilding unchanged cards during filter/sort changes.
                (context, index) => _ProductCardItem(
                  key: ValueKey(products[index].id),
                  product: products[index],
                ),
                childCount: products.length,
              ),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Extracted product card widget
// ─────────────────────────────────────────────────────────────────────────────

/// **Optimization Log:**
/// Extracting `_buildProductCard` into a proper `StatelessWidget` with a
/// `ValueKey` on the product ID means Flutter's element reconciler can:
///   (a) keep the widget alive in the sliver as items shift position.
///   (b) skip a rebuild entirely when the product data hasn't changed.
/// Previously the inline method was a plain function call — Flutter treats
/// the returned subtree as an anonymous widget and always rebuilds it.
///
/// The add-to-cart `BackdropFilter` is wrapped in a `RepaintBoundary` to
/// isolate it from the rest of the card's paint budget.
class _ProductCardItem extends StatelessWidget {
  final Product product;

  const _ProductCardItem({super.key, required this.product});

  // Constant decoration for the "NEW" gradient badge.
  static const _newBadgeDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.primaryContainer]),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mrp       = '₹${(product.price * 1.2).toStringAsFixed(0)}';
    final price     = '₹${product.price.toStringAsFixed(0)}';
    final category  = product.category.toUpperCase();

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: AppTheme.surfaceContainer,
                  child: AestheticNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: _newBadgeDecoration,
                    child: Text(
                      'NEW',
                      style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            fontSize: 10,
                          ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  // RepaintBoundary: isolates the blur effect so the card image
                  // and surrounding content are not repainted when only the
                  // button's compositing layer needs updating.
                  child: RepaintBoundary(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.surface.withValues(alpha: 0.8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_shopping_cart, color: AppTheme.primary, size: 20),
                            onPressed: () {
                              context.read<MockDataProvider>().addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Added to cart')),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                      letterSpacing: 4.0,
                      fontSize: 10,
                    ),
              ),
              const _InStockBadge(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                price,
                style: textTheme.titleMedium?.copyWith(color: AppTheme.primary),
              ),
              const SizedBox(width: 8),
              if (product.price > 1000)
                Text(
                  mrp,
                  style: textTheme.labelMedium?.copyWith(
                        color: AppTheme.outline,
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Const widget — built once, never rebuilt.
class _InStockBadge extends StatelessWidget {
  const _InStockBadge();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          'In Stock',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.green, fontSize: 10),
        ),
      ],
    );
  }
}

/// Fine-grained Consumer that only rebuilds the badge dot when cartCount changes.
/// Defined outside the screen class so it has its own element identity and
/// doesn't force the surrounding AppBar to rebuild.
class _CartBadge extends StatelessWidget {
  const _CartBadge();

  @override
  Widget build(BuildContext context) {
    final count = context.select<MockDataProvider, int>((p) => p.cartCount);
    if (count == 0) return const SizedBox.shrink();
    return Positioned(
      right: 8,
      top: 8,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
        child: Text(
          '$count',
          style: const TextStyle(
            color: AppTheme.onPrimary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter widgets (unchanged in appearance, kept as separate const classes)
// ─────────────────────────────────────────────────────────────────────────────

class _FilterOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterOption({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withValues(alpha: 0.15) : Colors.transparent,
          border: isSelected ? Border.all(color: AppTheme.primary.withValues(alpha: 0.4)) : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppTheme.primary : AppTheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }
}

class _PriceField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const _PriceField({required this.controller, required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.onSurfaceVariant.withValues(alpha: 0.5)),
        filled: true,
        fillColor: AppTheme.surfaceContainerLowest,
        prefixText: '₹  ',
        prefixStyle: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppTheme.outlineVariant),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppTheme.outlineVariant),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
