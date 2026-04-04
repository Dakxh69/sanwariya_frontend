import 'dart:math' as math;
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

class ShopCollectionScreen extends StatefulWidget {
  const ShopCollectionScreen({super.key});

  @override
  State<ShopCollectionScreen> createState() => _ShopCollectionScreenState();
}

class _ShopCollectionScreenState extends State<ShopCollectionScreen> {
  static const IconData filterAltOutlined = IconData(
    0xf068,
    fontFamily: 'MaterialIcons',
  );
  static const _sortMenuItems = [
    DropdownMenuItem<String>(
      value: 'Newest First',
      child: Text('Newest First'),
    ),
    DropdownMenuItem<String>(
      value: 'Price: Low to High',
      child: Text('Price: Low to High'),
    ),
    DropdownMenuItem<String>(
      value: 'Price: High to Low',
      child: Text('Price: High to Low'),
    ),
    DropdownMenuItem<String>(
      value: 'Best Selling',
      child: Text('Best Selling'),
    ),
  ];

  bool _showFilters = false;
  String _selectedCategory = 'All';
  String? _selectedPurity;
  final TextEditingController _minPriceCtrl = TextEditingController();
  final TextEditingController _maxPriceCtrl = TextEditingController();
  String _sortOrder = 'Newest First';
  static const int _itemsPerPage = 3;
  int _currentPage = 1;

  List<Product> _cachedFiltered = const [];

  int get _totalPages {
    final pages = (_cachedFiltered.length / _itemsPerPage).ceil();
    return pages == 0 ? 1 : pages;
  }

  List<Product> _productsForCurrentPage() {
    if (_cachedFiltered.isEmpty) {
      return const [];
    }

    final start = (_currentPage - 1) * _itemsPerPage;
    if (start >= _cachedFiltered.length) {
      return const [];
    }

    final end = math.min(start + _itemsPerPage, _cachedFiltered.length);
    return _cachedFiltered.sublist(start, end);
  }

  static const _categories = [
    'All',
    'Bangles',
    'Bracelets',
    'Chains',
    'Earrings',
    'Necklaces',
    'New',
    'Pendants',
    'Rings',
  ];
  static const _purities = ['0K', '18K', '22K', '24K'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _updateFilter();
  }

  @override
  void dispose() {
    _minPriceCtrl.dispose();
    _maxPriceCtrl.dispose();
    super.dispose();
  }

  void _updateFilter() {
    final products = context.read<MockDataProvider>().products;
    var result = products.where((p) {
      final selectedCategory = _selectedCategory.toLowerCase();
      final catMatch =
          selectedCategory == 'all' ||
          (selectedCategory == 'new'
              ? p.isNewArrival
              : p.category.toLowerCase() == selectedCategory);
      final minPrice = double.tryParse(_minPriceCtrl.text);
      final maxPrice = double.tryParse(_maxPriceCtrl.text);
      final minMatch = minPrice == null || p.price >= minPrice;
      final maxMatch = maxPrice == null || p.price <= maxPrice;
      return catMatch && minMatch && maxMatch;
    }).toList();

    if (_sortOrder == 'Price: Low to High') {
      result.sort((a, b) => a.price.compareTo(b.price));
    }
    if (_sortOrder == 'Price: High to Low') {
      result.sort((a, b) => b.price.compareTo(a.price));
    }

    _cachedFiltered = result;

    if (_currentPage > _totalPages) {
      _currentPage = _totalPages;
    }
  }

  void _clearFilters() {
    _minPriceCtrl.clear();
    _maxPriceCtrl.clear();
    setState(() {
      _selectedCategory = 'All';
      _selectedPurity = null;
      _currentPage = 1;
      _updateFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.select<MockDataProvider, List<Product>>((p) => p.products);

    final showBottom = Responsive.showBottomNav(context);
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.horizontalPadding(context);
    final filteredProducts = _cachedFiltered;
    final products = _productsForCurrentPage();

    return Scaffold(
      bottomNavigationBar: showBottom
          ? const GlassBottomNav(currentPath: '/collection')
          : null,
      backgroundColor: AppTheme.background,
      appBar: const SanwariyaAppBar(currentPath: '/collection'),
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
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 36,
                            letterSpacing: 1.0,
                          ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFFD1D5DB), // gray-300
                        Color(0xFF9CA3AF), // gray-400
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      'Discover our exquisite range of handcrafted jewellery',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, // required for gradient
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _showFilters = !_showFilters;
                    }),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      backgroundColor: _showFilters
                          ? AppTheme.primary
                          : Colors.transparent,
                      side: const BorderSide(color: AppTheme.primary),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    icon: Icon(
                      filterAltOutlined,
                      color: _showFilters ? Colors.black : Colors.white,
                    ),
                    label: Text(
                      _showFilters ? 'Hide Filters' : 'Show Filters',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: _showFilters ? Colors.black : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (_showFilters) ...[
                    const SizedBox(height: 24),
                    Container(
                      color: AppTheme.surfaceContainerLow,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          ..._categories.map(
                            (cat) => _FilterOption(
                              label: cat,
                              isSelected: _selectedCategory == cat,
                              onTap: () => setState(() {
                                _selectedCategory = cat;
                                _currentPage = 1;
                                _updateFilter();
                              }),
                            ),
                          ),

                          const SizedBox(height: 24),
                          Container(height: 1, color: AppTheme.outlineVariant),
                          const SizedBox(height: 24),

                          Text(
                            'Gold Purity',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          ..._purities.map(
                            (p) => _FilterOption(
                              label: p,
                              isSelected: _selectedPurity == p,
                              onTap: () => setState(() {
                                _selectedPurity = _selectedPurity == p
                                    ? null
                                    : p;
                                _currentPage = 1;
                                _updateFilter();
                              }),
                            ),
                          ),

                          const SizedBox(height: 24),
                          Container(height: 1, color: AppTheme.outlineVariant),
                          const SizedBox(height: 24),

                          Text(
                            'Price Range',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _PriceField(
                            controller: _minPriceCtrl,
                            hint: 'Min Price',
                            onChanged: (_) => setState(() {
                              _currentPage = 1;
                              _updateFilter();
                            }),
                          ),
                          const SizedBox(height: 12),
                          _PriceField(
                            controller: _maxPriceCtrl,
                            hint: 'Max Price',
                            onChanged: (_) => setState(() {
                              _currentPage = 1;
                              _updateFilter();
                            }),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: _clearFilters,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                side: const BorderSide(color: AppTheme.primary),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: Text(
                                'Clear Filters',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
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
                        '${filteredProducts.length} products found',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
                            icon: const Icon(
                              Icons.expand_more,
                              color: AppTheme.outline,
                            ),
                            dropdownColor: AppTheme.surfaceContainerHigh,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppTheme.onSurface,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                            items: _sortMenuItems,
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
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SizedBox(
                    height: isDesktop ? 650 : 560,
                    child: _ProductCardItem(
                      key: ValueKey(products[index].id),
                      product: products[index],
                      metaLabel: _selectedPurity ?? 'N/A',
                    ),
                  ),
                ),
                childCount: products.length,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: hPad.copyWith(top: 8, bottom: 24),
              child: _CollectionPaginationFooter(
                currentPage: _currentPage,
                totalPages: _totalPages,
                onPrevious: _currentPage > 1
                    ? () => setState(() => _currentPage--)
                    : null,
                onNext: _currentPage < _totalPages
                    ? () => setState(() => _currentPage++)
                    : null,
              ),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

class _CollectionPaginationFooter extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const _CollectionPaginationFooter({
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final borderColor = AppTheme.outlineVariant.withValues(alpha: 0.85);

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _PaginationButton(
                label: 'Previous',
                onPressed: onPrevious,
                borderColor: borderColor,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Page $currentPage of $totalPages',
                style: GoogleFonts.inter(
                  textStyle: textTheme.titleMedium,
                  color: AppTheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _PaginationButton(
                label: 'Next',
                onPressed: onNext,
                borderColor: borderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color borderColor;

  const _PaginationButton({
    required this.label,
    required this.onPressed,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(84, 40),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: AppTheme.background,
        side: BorderSide(color: borderColor),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.titleMedium,
          color: isEnabled
              ? AppTheme.onSurface
              : AppTheme.onSurfaceVariant.withValues(alpha: 0.6),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _ProductCardItem extends StatelessWidget {
  final Product product;
  final String metaLabel;

  const _ProductCardItem({
    super.key,
    required this.product,
    required this.metaLabel,
  });

  static const _discountBadgeDecoration = BoxDecoration(
    color: AppTheme.primary,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const discountPercent = 10;
    final mrp =
        '₹${(product.price / (1 - (discountPercent / 100))).toStringAsFixed(0)}';
    final price = '₹${product.price.toStringAsFixed(0)}';
    final category = product.category.toUpperCase();

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
            Expanded(
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
                      decoration: _discountBadgeDecoration,
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
                  "In Stock",
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

class _FilterOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          border: isSelected
              ? Border.all(color: AppTheme.primary.withValues(alpha: 0.4))
              : null,
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

  const _PriceField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: AppTheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppTheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: AppTheme.surfaceContainerLowest,
        prefixText: '₹  ',
        prefixStyle: const TextStyle(
          color: AppTheme.primary,
          fontWeight: FontWeight.bold,
        ),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
