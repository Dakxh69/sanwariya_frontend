import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/network_image.dart';
import '../widgets/nav_menu.dart';
import '../widgets/glass_bottom_nav.dart';

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

  static const _categories = ['All', 'Bangles', 'Bracelets', 'Chains', 'Earrings', 'Necklaces', 'Pendants', 'Rings'];
  static const _purities = ['0K', '18K', '22K', '24K'];

  @override
  void dispose() {
    _minPriceCtrl.dispose();
    _maxPriceCtrl.dispose();
    super.dispose();
  }

  List<Product> _filteredProducts(List<Product> products) {
    var result = products.where((p) {
      final catMatch = _selectedCategory == 'All' || p.category.toLowerCase() == _selectedCategory.toLowerCase();
      final minPrice = double.tryParse(_minPriceCtrl.text);
      final maxPrice = double.tryParse(_maxPriceCtrl.text);
      final minMatch = minPrice == null || p.price >= minPrice;
      final maxMatch = maxPrice == null || p.price <= maxPrice;
      return catMatch && minMatch && maxMatch;
    }).toList();

    if (_sortOrder == 'Price: Low to High') result.sort((a, b) => a.price.compareTo(b.price));
    if (_sortOrder == 'Price: High to Low') result.sort((a, b) => b.price.compareTo(a.price));

    return result;
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = 'All';
      _selectedPurity = null;
      _minPriceCtrl.clear();
      _maxPriceCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = context.watch<MockDataProvider>().products;
    final products = _filteredProducts(allProducts);

    return Scaffold(
      bottomNavigationBar: const GlassBottomNav(currentPath: '/collection'),
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
          IconButton(icon: const Icon(Icons.menu), onPressed: () => NavMenu.show(context, currentPath: '/collection')),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
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
                    onPressed: () => setState(() => _showFilters = !_showFilters),
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
                          // Categories
                          Text('Categories', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          ..._categories.map((cat) => _FilterOption(
                                label: cat,
                                isSelected: _selectedCategory == cat,
                                onTap: () => setState(() => _selectedCategory = cat),
                              )),

                          const SizedBox(height: 24),
                          Container(height: 1, color: AppTheme.outlineVariant),
                          const SizedBox(height: 24),

                          // Gold Purity
                          Text('Gold Purity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          ..._purities.map((p) => _FilterOption(
                                label: p,
                                isSelected: _selectedPurity == p,
                                onTap: () => setState(() => _selectedPurity = _selectedPurity == p ? null : p),
                              )),

                          const SizedBox(height: 24),
                          Container(height: 1, color: AppTheme.outlineVariant),
                          const SizedBox(height: 24),

                          // Price Range
                          Text('Price Range', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _PriceField(controller: _minPriceCtrl, hint: 'Min Price', onChanged: (_) => setState(() {})),
                          const SizedBox(height: 12),
                          _PriceField(controller: _maxPriceCtrl, hint: 'Max Price', onChanged: (_) => setState(() {})),

                          const SizedBox(height: 24),

                          // Clear Filters
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
                            onChanged: (v) => setState(() => _sortOrder = v ?? _sortOrder),
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                mainAxisSpacing: 32,
                crossAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildProductCard(context, products[index]),
                childCount: products.length,
              ),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryContainer],
                      ),
                    ),
                    child: Text(
                      'NEW',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.category.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                      letterSpacing: 4.0,
                      fontSize: 10,
                    ),
              ),
              Row(
                children: [
                  Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('In Stock', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.green, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '₹${product.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.primary),
              ),
              const SizedBox(width: 8),
              if (product.price > 1000)
                Text(
                  '₹${(product.price * 1.2).toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
        prefixStyle: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
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
