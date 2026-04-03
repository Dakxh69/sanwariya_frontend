import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/sanwariya_app_bar.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  static const _intro =
      "Discover amazing deals on our finest jewelry collection. Limited time offers you don't want to miss!";

  static const _deals = <_OfferDealData>[
    _OfferDealData(
      ribbonLabel: '₹10000 OFF',
      amountLabel: '₹10000 OFF',
      title: 'Diamond Collection Special',
      description:
          'Get flat ₹10,000 off on premium diamond jewelry. Make your moments special!',
      minPurchase: '₹50000',
      validOn: 'Rings, Necklaces',
      validTill: 'April 15, 2026',
    ),
    _OfferDealData(
      ribbonLabel: '₹5000 OFF',
      amountLabel: '₹5000 OFF',
      title: 'Wedding Season Special',
      description:
          'Flat ₹5000 off on bridal jewelry collection. Perfect for your big day!',
      minPurchase: '₹30000',
      validOn: 'Necklaces, Earrings, Rings',
      validTill: 'May 31, 2026',
    ),
  ];

  static const _features = <_OfferFeatureData>[
    _OfferFeatureData(
      icon: '✨',
      title: 'Limited Time',
      description: 'Exclusive offers available for a limited period only',
    ),
    _OfferFeatureData(
      icon: '🎁',
      title: 'Special Deals',
      description: 'Get amazing discounts on premium jewelry collections',
    ),
    _OfferFeatureData(
      icon: '💎',
      title: 'Authentic Products',
      description: 'All offers valid on 100% authentic certified jewelry',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final showBottom = Responsive.showBottomNav(context);
    final horizontalPadding = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16),
      tablet: const EdgeInsets.symmetric(horizontal: 26),
      desktop: const EdgeInsets.symmetric(horizontal: 90),
    );
    final headingSize = Responsive.value<double>(
      context,
      mobile: 32,
      tablet: 38,
      desktop: 44,
    );
    final bodySize = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 17,
      desktop: 18,
    );
    final maxContentWidth = Responsive.value<double>(
      context,
      mobile: 760,
      tablet: 760,
      desktop: 840,
    );

    return Scaffold(
      bottomNavigationBar: showBottom
          ? const GlassBottomNav(currentPath: '/offers')
          : null,
      backgroundColor: AppTheme.surface,
      appBar: const SanwariyaAppBar(currentPath: '/offers'),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF191611),
                        AppTheme.surfaceContainerLow,
                        AppTheme.surface,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: const [0.0, 0.2, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding.left,
                      54,
                      horizontalPadding.right,
                      58,
                    ),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.playfairDisplay(
                              color: AppTheme.onSurface,
                              fontSize: headingSize,
                              fontWeight: FontWeight.w700,
                              height: 1.08,
                            ),
                            children: const [
                              TextSpan(text: 'Exclusive '),
                              TextSpan(
                                text: 'Offers',
                                style: TextStyle(color: AppTheme.primary),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _intro,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: bodySize,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding.left,
                    24,
                    horizontalPadding.right,
                    0,
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < _deals.length; i++) ...[
                        _OfferDealCard(data: _deals[i]),
                        if (i != _deals.length - 1) const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding.left,
                    24,
                    horizontalPadding.right,
                    0,
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < _features.length; i++) ...[
                        _OfferFeatureCard(data: _features[i]),
                        if (i != _features.length - 1)
                          const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding.left,
                    26,
                    horizontalPadding.right,
                    showBottom ? 110 : 46,
                  ),
                  child: const _OffersSubscribeCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OfferDealCard extends StatelessWidget {
  final _OfferDealData data;

  const _OfferDealCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final widthFactor = Responsive.value<double>(
      context,
      mobile: 0.94,
      tablet: 0.9,
      desktop: 0.84,
    );
    final minHeight = Responsive.value<double>(
      context,
      mobile: 640,
      tablet: 680,
      desktop: 720,
    );

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              border: Border.all(
                color: AppTheme.outlineVariant.withValues(alpha: 0.4),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 228),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A3A19),
                        const Color(0xFF252018),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          child: Text(
                            data.ribbonLabel,
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🎉', style: TextStyle(fontSize: 30)),
                            const SizedBox(height: 10),
                            Text(
                              data.amountLabel,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppTheme.primary,
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  data.title,
                  style: GoogleFonts.playfairDisplay(
                    color: AppTheme.onSurface,
                    fontSize: 25,
                    height: 1.08,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data.description,
                  style: GoogleFonts.inter(
                    color: AppTheme.onSurfaceVariant,
                    fontSize: 16,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  color: AppTheme.outlineVariant.withValues(alpha: 0.45),
                  height: 1,
                ),
                const SizedBox(height: 12),
                _DealInfoLine(
                  icon: '💳',
                  text: 'Min. Purchase: ${data.minPurchase}',
                ),
                const SizedBox(height: 8),
                _DealInfoLine(icon: '🏷️', text: 'Valid on: ${data.validOn}'),
                const SizedBox(height: 8),
                _DealInfoLine(
                  icon: '🗓️',
                  text: 'Valid till ${data.validTill}',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.push('/collection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      minimumSize: const Size.fromHeight(62),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Shop Now',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    'View Terms & Conditions',
                    style: GoogleFonts.inter(
                      color: AppTheme.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DealInfoLine extends StatelessWidget {
  final String icon;
  final String text;

  const _DealInfoLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: AppTheme.onSurfaceVariant,
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferFeatureCard extends StatelessWidget {
  final _OfferFeatureData data;

  const _OfferFeatureCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final widthFactor = Responsive.value<double>(
      context,
      mobile: 0.94,
      tablet: 0.9,
      desktop: 0.84,
    );

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            border: Border.all(
              color: AppTheme.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
          child: Column(
            children: [
              Text(data.icon, style: const TextStyle(fontSize: 42)),
              const SizedBox(height: 12),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  color: AppTheme.onSurface,
                  fontSize: 24,
                  height: 1.05,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OffersSubscribeCard extends StatelessWidget {
  const _OffersSubscribeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF201A11),
            AppTheme.surfaceContainerLow,
            AppTheme.surface,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 0.28, 1.0],
        ),
        border: Border.all(
          color: AppTheme.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 34, 24, 34),
      child: Column(
        children: [
          Text(
            "Don't Miss Out\non These Deals!",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              color: AppTheme.onSurface,
              fontSize: 26,
              height: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Subscribe to our\nnewsletter to get notified\nabout new offers and\nexclusive deals',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppTheme.onSurfaceVariant,
              fontSize: 16,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF8D95A8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: const Color(0xFF070B16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppTheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppTheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AppTheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
            ),
            style: GoogleFonts.inter(
              color: AppTheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                'Subscribe',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferDealData {
  final String ribbonLabel;
  final String amountLabel;
  final String title;
  final String description;
  final String minPurchase;
  final String validOn;
  final String validTill;

  const _OfferDealData({
    required this.ribbonLabel,
    required this.amountLabel,
    required this.title,
    required this.description,
    required this.minPurchase,
    required this.validOn,
    required this.validTill,
  });
}

class _OfferFeatureData {
  final String icon;
  final String title;
  final String description;

  const _OfferFeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
