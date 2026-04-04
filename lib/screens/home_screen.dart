import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/network_image.dart';
import '../widgets/sanwariya_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showBottom = Responsive.showBottomNav(context);

    return Scaffold(
      backgroundColor: _HomePalette.background,
      extendBody: true,
      appBar: const SanwariyaAppBar(
        currentPath: '/',
        backgroundColor: _HomePalette.background,
        titleColor: _HomePalette.accent,
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: RepaintBoundary(
              child: IgnorePointer(
                child: CustomPaint(painter: _LuxuryCurvesPainter()),
              ),
            ),
          ),
          CustomScrollView(
            cacheExtent: 1400,
            slivers: [
              const SliverToBoxAdapter(child: _HeroSection()),
              const SliverToBoxAdapter(child: SizedBox(height: 52)),
              const SliverToBoxAdapter(child: _FeaturedHeaderSection()),
              const _FeaturedProductsSliver(),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              const SliverToBoxAdapter(child: _ViewAllProductsButton()),
              const SliverToBoxAdapter(child: SizedBox(height: 42)),
              const SliverToBoxAdapter(child: _CategoryExploreHeader()),
              const _CategoryListSliver(),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              const SliverToBoxAdapter(child: _OurPromiseSection()),
              SliverToBoxAdapter(
                child: SizedBox(height: showBottom ? 100 : 48),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: showBottom
          ? const GlassBottomNav(currentPath: '/')
          : null,
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  static const heroImageUrl =
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=1200&q=80';

  static const _heroRadius = BorderRadius.all(Radius.circular(22));
  static const _heroPanelDecoration = BoxDecoration(
    color: _HomePalette.heroPlaceholder,
    borderRadius: _heroRadius,
    border: Border.fromBorderSide(BorderSide(color: Color(0x33F2CA50))),
    boxShadow: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 26,
        offset: Offset(0, 14),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final outerPadding = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      tablet: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      desktop: const EdgeInsets.fromLTRB(80, 24, 80, 0),
    );

    final headingSize = Responsive.value<double>(
      context,
      mobile: 48,
      tablet: 56,
      desktop: 64,
    );

    final bodySize = Responsive.value<double>(
      context,
      mobile: 15,
      tablet: 16,
      desktop: 17,
    );

    return Padding(
      padding: outerPadding,
      child: Column(
        children: [
          RepaintBoundary(
            child: AspectRatio(
              aspectRatio: Responsive.value<double>(
                context,
                mobile: 1.22,
                tablet: 1.45,
                desktop: 2.05,
              ),
              child: ClipRRect(
                borderRadius: _heroRadius,
                child: DecoratedBox(
                  decoration: _heroPanelDecoration,
                  child: heroImageUrl.isEmpty
                      ? const SizedBox.expand()
                      : const AestheticNetworkImage(
                          imageUrl: heroImageUrl,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.zero,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 58),
          Text(
            'Elegant &\nLuxury',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: headingSize,
              height: 1.08,
              fontWeight: FontWeight.w600,
              color: _HomePalette.primaryText,
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: bodySize,
                  height: 1.45,
                  color: _HomePalette.secondaryText,
                  fontWeight: FontWeight.w500,
                ),
                children: const [
                  TextSpan(
                    text:
                        'Discover exclusive deals! Free shipping on your first order. ',
                  ),
                  TextSpan(
                    text: 'Shop now and save big!',
                    style: TextStyle(
                      color: _HomePalette.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.push('/collection'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                'SHOP COLLECTION',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _AnimatedDownArrow(),
        ],
      ),
    );
  }
}

class _AnimatedDownArrow extends StatefulWidget {
  const _AnimatedDownArrow();

  @override
  State<_AnimatedDownArrow> createState() => _AnimatedDownArrowState();
}

class _AnimatedDownArrowState extends State<_AnimatedDownArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _verticalOffset;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _verticalOffset = Tween<double>(begin: -2, end: 8).animate(curve);
    _opacity = Tween<double>(begin: 0.55, end: 1).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: Offset(0, _verticalOffset.value),
              child: child,
            ),
          );
        },
        child: const Icon(
          Icons.south_rounded,
          color: _HomePalette.accent,
          size: 30,
        ),
      ),
    );
  }
}

class _FeaturedHeaderSection extends StatelessWidget {
  const _FeaturedHeaderSection();

  @override
  Widget build(BuildContext context) {
    final contentPadding = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      tablet: const EdgeInsets.fromLTRB(28, 0, 28, 0),
      desktop: const EdgeInsets.fromLTRB(80, 0, 80, 0),
    );

    final headingSize = Responsive.value<double>(
      context,
      mobile: 42,
      tablet: 48,
      desktop: 54,
    );

    final bodySize = Responsive.value<double>(
      context,
      mobile: 15,
      tablet: 16,
      desktop: 17,
    );

    return Padding(
      padding: contentPadding,
      child: Column(
        children: [
          Text(
            'CURATED SELECTION',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: _HomePalette.accent,
              fontSize: 13,
              letterSpacing: 5.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Featured Collection',
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: headingSize,
                  height: 1.06,
                  color: _HomePalette.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'Handpicked masterpieces that embody luxury, craftsmanship, and timeless beauty',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: _HomePalette.secondaryText,
                fontSize: bodySize,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProductsSliver extends StatelessWidget {
  const _FeaturedProductsSliver();

  @override
  Widget build(BuildContext context) {
    return Selector<MockDataProvider, List<Product>>(
      selector: (_, provider) => provider.products,
      builder: (context, products, _) {
        if (products.isEmpty) {
          return const SliverToBoxAdapter(child: _EmptyFeaturedState());
        }

        final contentPadding = Responsive.value<EdgeInsets>(
          context,
          mobile: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          tablet: const EdgeInsets.fromLTRB(24, 28, 24, 0),
          desktop: const EdgeInsets.fromLTRB(80, 36, 80, 0),
        );

        return SliverPadding(
          padding: contentPadding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: RepaintBoundary(
                  child: _HomeProductCard(
                    key: ValueKey(product.id),
                    product: product,
                  ),
                ),
              );
            }, childCount: products.length),
          ),
        );
      },
    );
  }
}

class _ViewAllProductsButton extends StatelessWidget {
  const _ViewAllProductsButton();

  @override
  Widget build(BuildContext context) {
    final width = Responsive.value<double>(
      context,
      mobile: 240,
      tablet: 290,
      desktop: 320,
    );

    final horizontal = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16),
      tablet: const EdgeInsets.symmetric(horizontal: 24),
      desktop: const EdgeInsets.symmetric(horizontal: 80),
    );

    return Padding(
      padding: horizontal,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: width,
          height: 56,
          child: FilledButton(
            onPressed: () => context.push('/collection'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF111111),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View All Products',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryExploreHeader extends StatelessWidget {
  const _CategoryExploreHeader();

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 14),
      tablet: const EdgeInsets.symmetric(horizontal: 28),
      desktop: const EdgeInsets.symmetric(horizontal: 96),
    );

    return Padding(
      padding: horizontal,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: _HomePalette.categoryPanel,
          border: Border.fromBorderSide(
            BorderSide(color: _HomePalette.categoryPanelBorder),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 56),
        child: Column(
          children: [
            Text(
              'EXPLORE',
              style: GoogleFonts.inter(
                color: _HomePalette.accent,
                fontSize: 14,
                letterSpacing: 4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Shop by Category',
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                color: _HomePalette.primaryText,
                fontSize: Responsive.value<double>(
                  context,
                  mobile: 40,
                  tablet: 46,
                  desktop: 52,
                ),
                height: 1.05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryListSliver extends StatelessWidget {
  const _CategoryListSliver();

  @override
  Widget build(BuildContext context) {
    return Selector<MockDataProvider, List<Category>>(
      selector: (_, provider) => provider.categories,
      builder: (context, categories, _) {
        if (categories.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final horizontal = Responsive.value<EdgeInsets>(
          context,
          mobile: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          tablet: const EdgeInsets.fromLTRB(28, 16, 28, 0),
          desktop: const EdgeInsets.fromLTRB(96, 20, 96, 0),
        );

        return SliverPadding(
          padding: horizontal,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: RepaintBoundary(
                  child: _CategoryListCard(category: category),
                ),
              );
            }, childCount: categories.length),
          ),
        );
      },
    );
  }
}

class _CategoryListCard extends StatelessWidget {
  final Category category;

  const _CategoryListCard({required this.category});

  String _subtitle(String name) {
    return 'Traditional and modern ${name.toLowerCase()} in gold, silver, and precious stones';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/browse'),
      child: Container(
        decoration: const BoxDecoration(
          color: _HomePalette.categoryPanel,
          border: Border.fromBorderSide(
            BorderSide(color: _HomePalette.categoryPanelBorder),
          ),
        ),
        child: AspectRatio(
          aspectRatio: Responsive.value<double>(
            context,
            mobile: 1.0,
            tablet: 1.35,
            desktop: 1.65,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              RepaintBoundary(
                child: AestheticNetworkImage(
                  imageUrl: category.imageUrl,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.zero,
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xCC06080E), Color(0x1006080E)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.55],
                  ),
                ),
              ),
              Positioned(
                left: 22,
                right: 22,
                bottom: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: GoogleFonts.playfairDisplay(
                        color: _HomePalette.primaryText,
                        fontSize: Responsive.value<double>(
                          context,
                          mobile: 32,
                          tablet: 36,
                          desktop: 40,
                        ),
                        height: 1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _subtitle(category.name),
                      style: GoogleFonts.inter(
                        color: _HomePalette.categoryBody,
                        fontSize: Responsive.value<double>(
                          context,
                          mobile: 13,
                          tablet: 14,
                          desktop: 15,
                        ),
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore',
                          style: GoogleFonts.inter(
                            color: _HomePalette.accent,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                          color: _HomePalette.accent,
                          size: Responsive.value<double>(
                            context,
                            mobile: 20,
                            tablet: 22,
                            desktop: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OurPromiseSection extends StatelessWidget {
  const _OurPromiseSection();

  static const _storyText =
      'At Sanwariya Imitation, every piece tells a story. Our master artisans blend traditional techniques with contemporary design, creating jewelry that transcends time. Each creation is a testament to our unwavering commitment to excellence.';

  static const _premiumQualitySvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z"/>
  <path d="M5 3v4"/>
  <path d="M19 17v4"/>
  <path d="M3 5h4"/>
  <path d="M17 19h4"/>
</svg>
  ''';

  static const _masterArtisansSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="12" cy="8" r="6"/>
  <path d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"/>
</svg>
  ''';

  static const _points = <_PromisePointData>[
    _PromisePointData(
      svgIcon: _premiumQualitySvg,
      title: 'Premium Quality',
      description:
          'Only the finest gold, ethically sourced and certified for purity.',
    ),
    _PromisePointData(
      svgIcon: _masterArtisansSvg,
      title: 'Master Artisans',
      description:
          'Handcrafted by skilled jewelers with decades of experience.',
    ),
    _PromisePointData(
      icon: Icons.shield_outlined,
      title: 'Lifetime Warranty',
      description:
          'Every piece comes with comprehensive warranty and certification.',
    ),
    _PromisePointData(
      icon: Icons.trending_up,
      title: 'Investment Value',
      description: 'Jewelry that appreciates in both sentiment and worth.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      tablet: const EdgeInsets.fromLTRB(24, 18, 24, 0),
      desktop: const EdgeInsets.fromLTRB(80, 24, 80, 0),
    );

    final titleSize = Responsive.value<double>(
      context,
      mobile: 44,
      tablet: 52,
      desktop: 58,
    );

    final bodySize = Responsive.value<double>(
      context,
      mobile: 18,
      tablet: 19,
      desktop: 20,
    );

    final titleStyle = GoogleFonts.playfairDisplay(
      color: _HomePalette.primaryText,
      fontSize: titleSize,
      height: 1.04,
      fontWeight: FontWeight.w700,
    );

    final goldGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFB8962E),
        Color(0xFFD4AF37),
        Color(0xFFF5E6C8),
        Color(0xFFE6C76A),
      ],
      stops: [0.0, 0.3, 0.6, 1.0],
    );

    return Padding(
      padding: horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUR PROMISE',
            style: GoogleFonts.inter(
              color: _HomePalette.accent,
              fontSize: 13,
              letterSpacing: 6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text('Craftsmanship', style: titleStyle),
          Wrap(
            spacing: 10,
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return goldGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  );
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  'Beyond',
                  style: titleStyle.copyWith(color: Colors.white),
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) {
                  return goldGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  );
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  'Compare',
                  style: titleStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            _storyText,
            style: GoogleFonts.inter(
              color: _HomePalette.secondaryText,
              fontSize: bodySize,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 26),
          for (final point in _points)
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: _PromisePointTile(point: point),
            ),
        ],
      ),
    );
  }
}

class _PromisePointTile extends StatelessWidget {
  final _PromisePointData point;

  const _PromisePointTile({required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: _HomePalette.promiseIconBg,
            shape: BoxShape.circle,
          ),
          child: point.svgIcon != null
              ? Center(
                  child: SvgPicture.string(
                    point.svgIcon!,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      _HomePalette.accentSoft,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : Icon(point.icon, color: _HomePalette.accent, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                point.title,
                style: GoogleFonts.playfairDisplay(
                  color: _HomePalette.primaryText,
                  fontSize: Responsive.value<double>(
                    context,
                    mobile: 22,
                    tablet: 24,
                    desktop: 26,
                  ),
                  height: 1.05,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                point.description,
                style: GoogleFonts.inter(
                  color: _HomePalette.secondaryText,
                  fontSize: Responsive.value<double>(
                    context,
                    mobile: 16,
                    tablet: 17,
                    desktop: 18,
                  ),
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PromisePointData {
  final IconData? icon;
  final String? svgIcon;
  final String title;
  final String description;

  const _PromisePointData({
    this.icon,
    this.svgIcon,
    required this.title,
    required this.description,
  }) : assert(icon != null || svgIcon != null);
}

class _EmptyFeaturedState extends StatelessWidget {
  const _EmptyFeaturedState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
      child: Text(
        'No products available right now.',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: _HomePalette.secondaryText,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
  final Product product;

  const _HomeProductCard({super.key, required this.product});

  static const _cardDecoration = BoxDecoration(
    color: _HomePalette.productCard,
    border: Border.fromBorderSide(
      BorderSide(color: _HomePalette.productCardBorder),
    ),
  );

  static const _discountBadgeDecoration = BoxDecoration(
    color: _HomePalette.accent,
  );

  int _discountPercent() {
    final seed = _extractNumericId(product.id);
    return seed % 3 == 1 ? 8 : 6;
  }

  String _purityLabel() {
    const purityValues = ['18K', '22K', '24K'];
    final seed = _extractNumericId(product.id);
    return purityValues[seed % purityValues.length];
  }

  static int _extractNumericId(String id) {
    final numeric = id.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numeric) ?? 0;
  }

  static String _formatPrice(double value) {
    final rounded = value.round();
    return '₹${_formatIndianNumber(rounded)}';
  }

  static String _formatIndianNumber(int value) {
    final digits = value.toString();
    if (digits.length <= 3) {
      return digits;
    }

    final lastThree = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);

    final parts = <String>[];
    while (rest.length > 2) {
      parts.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }

    if (rest.isNotEmpty) {
      parts.insert(0, rest);
    }

    return '${parts.join(',')},$lastThree';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final discountPercent = _discountPercent();
    final originalPrice = product.price / (1 - (discountPercent / 100));
    final category = product.category.toUpperCase();

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: _cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: Responsive.value<double>(
                context,
                mobile: 1.08,
                tablet: 1.45,
                desktop: 1.75,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: _HomePalette.imageSurface,
                    child: RepaintBoundary(
                      child: AestheticNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: _discountBadgeDecoration,
                      child: Text(
                        '$discountPercent% OFF',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0C0C0C),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              category,
              style: GoogleFonts.inter(
                textStyle: textTheme.labelSmall,
                color: _HomePalette.accent,
                letterSpacing: 1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay(
                textStyle: textTheme.headlineSmall?.copyWith(
                  color: _HomePalette.primaryText,
                  height: 1.12,
                ),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _formatPrice(product.price),
                  style: textTheme.headlineMedium?.copyWith(
                    color: _HomePalette.accent,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  _formatPrice(originalPrice),
                  style: textTheme.titleMedium?.copyWith(
                    color: _HomePalette.strikeText,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _purityLabel(),
                  style: textTheme.titleMedium?.copyWith(
                    color: _HomePalette.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'In Stock',
                  style: GoogleFonts.inter(
                    color: _HomePalette.stockText,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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

class _LuxuryCurvesPainter extends CustomPainter {
  const _LuxuryCurvesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final primary = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = const Color(0x2AF2CA50);

    final secondary = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.65
      ..color = const Color(0x1FD4AF37);

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width * -0.18, size.height * 0.40),
        radius: size.width * 1.05,
      ),
      -0.34 * math.pi,
      1.28 * math.pi,
      false,
      primary,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width * 1.10, size.height * 0.62),
        radius: size.width * 1.12,
      ),
      0.52 * math.pi,
      1.28 * math.pi,
      false,
      secondary,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width * 0.46, size.height * 1.13),
        radius: size.width * 0.92,
      ),
      1.03 * math.pi,
      0.95 * math.pi,
      false,
      primary,
    );
  }

  @override
  bool shouldRepaint(covariant _LuxuryCurvesPainter oldDelegate) {
    return false;
  }
}

class _HomePalette {
  static const Color background = Color(0xFF06080E);
  static const Color heroPlaceholder = Color(0xFF151A24);

  static const Color accent = Color(0xFFF2CA50);
  static const Color accentSoft = Color(0xFFD4AF37);

  static const Color primaryText = Color(0xFFF4F1EA);
  static const Color secondaryText = Color(0xFFD1D8E2);
  static const Color strikeText = Color(0xFF9EA3AF);

  static const Color productCard = Color(0xFF0F121B);
  static const Color productCardBorder = Color(0xFF1B2333);
  static const Color imageSurface = Color(0xFF090D18);
  static const Color categoryPanel = Color(0xFF0D1019);
  static const Color categoryPanelBorder = Color(0xFF1F2635);
  static const Color categoryBody = Color(0xFFD4D7DE);
  static const Color promiseIconBg = Color(0xFF1A1D23);

  static const Color stockText = Color(0xFF48FF9B);
}
