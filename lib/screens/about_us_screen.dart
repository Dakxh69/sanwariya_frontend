import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/sanwariya_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const _introText =
      'Crafting timeless elegance since inception. We are dedicated to bringing you the finest jewelry with exceptional craftsmanship and unparalleled quality.';

  static const _storyParagraphs = <String>[
    'Sanwariya Imitation was born from a passion for exquisite craftsmanship and timeless beauty. Our journey began with a simple vision: to create jewelry that tells a story, celebrates moments, and becomes a cherished part of your life.',
    'Every piece in our collection is carefully curated and crafted by master artisans who pour their expertise and love into each creation. We source only the finest materials, from ethically-sourced diamonds to precious metals, ensuring that every piece meets our exacting standards.',
    'Today, Sanwariya Imitation stands as a testament to our commitment to excellence, innovation, and the timeless art of jewelry making. We continue to push boundaries while honoring traditional techniques that have been passed down through generations.',
  ];

  static const _values = <_ValueData>[
    _ValueData(
      icon: '✨',
      title: 'Quality',
      description:
          'We never compromise on quality. Every piece is crafted to perfection with meticulous attention to detail.',
    ),
    _ValueData(
      icon: '🤝',
      title: 'Trust',
      description:
          'Building lasting relationships through transparency, authenticity, and exceptional customer service.',
    ),
    _ValueData(
      icon: '🌟',
      title: 'Innovation',
      description:
          'Blending traditional craftsmanship with modern design to create jewelry that stands the test of time.',
    ),
    _ValueData(
      icon: '💚',
      title: 'Sustainability',
      description:
          'Committed to ethical sourcing and sustainable practices that respect our planet and communities.',
    ),
    _ValueData(
      icon: '🎨',
      title: 'Artistry',
      description:
          'Celebrating the art of jewelry making with designs that reflect beauty, elegance, and individuality.',
    ),
    _ValueData(
      icon: '💎',
      title: 'Excellence',
      description:
          'Setting the highest standards in every aspect, from design to customer experience.',
    ),
  ];

  static const _craftsmanshipParagraphs = <String>[
    'Our master craftsmen bring decades of experience and unparalleled skill to every piece they create. Each jewelry item goes through rigorous quality checks to ensure it meets our exacting standards.',
    'From the initial design concept to the final polish, we oversee every step of the creation process. Our artisans use both time-honored techniques and cutting-edge technology to achieve perfection in every detail.',
  ];

  static const _stats = <_StatData>[
    _StatData(value: '50+', label: 'Expert Craftsmen'),
    _StatData(value: '100%', label: 'Quality Assured'),
    _StatData(value: '1000+', label: 'Happy Customers'),
    _StatData(value: '500+', label: 'Unique Designs'),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 28,
      desktop: 64,
    );
    final headingSize = Responsive.value<double>(
      context,
      mobile: 34,
      tablet: 40,
      desktop: 44,
    );
    final bodySize = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 17,
      desktop: 18,
    );
    final sectionHeadingSize = Responsive.value<double>(
      context,
      mobile: 30,
      tablet: 34,
      desktop: 38,
    );
    final ctaHeadingSize = Responsive.value<double>(
      context,
      mobile: 28,
      tablet: 32,
      desktop: 36,
    );

    const maxWidth = 760.0;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: const SanwariyaAppBar(currentPath: '/about'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppTheme.surface,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontal,
                      52,
                      horizontal,
                      54,
                    ),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.playfairDisplay(
                              color: AppTheme.onSurface,
                              fontSize: headingSize,
                              height: 1.05,
                              fontWeight: FontWeight.w700,
                            ),
                            children: const [
                              TextSpan(text: 'About '),
                              TextSpan(
                                text: 'Sanwariya\n',
                                style: TextStyle(color: AppTheme.primary),
                              ),
                              TextSpan(
                                text: 'Imitation',
                                style: TextStyle(color: AppTheme.primary),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _introText,
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
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(horizontal, 44, horizontal, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.playfairDisplay(
                            fontSize: headingSize,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                          ),
                          children: const [
                            TextSpan(text: 'Our '),
                            TextSpan(
                              text: 'Story',
                              style: TextStyle(color: AppTheme.primary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      for (var i = 0; i < _storyParagraphs.length; i++) ...[
                        Text(
                          _storyParagraphs[i],
                          style: GoogleFonts.inter(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: bodySize,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (i != _storyParagraphs.length - 1)
                          const SizedBox(height: 26),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(horizontal, 48, horizontal, 34),
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.playfairDisplay(
                            fontSize: headingSize,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                          ),
                          children: const [
                            TextSpan(text: 'Our '),
                            TextSpan(
                              text: 'Values',
                              style: TextStyle(color: AppTheme.primary),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'The principles that guide everything we do',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppTheme.onSurfaceVariant,
                          fontSize: bodySize,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 26),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _values.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return _ValueCard(value: _values[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(horizontal, 24, horizontal, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.playfairDisplay(
                            fontSize: sectionHeadingSize,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                            height: 1.05,
                          ),
                          children: const [
                            TextSpan(text: 'Exceptional\n'),
                            TextSpan(
                              text: 'Craftsmanship',
                              style: TextStyle(color: AppTheme.primary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      for (
                        var i = 0;
                        i < _craftsmanshipParagraphs.length;
                        i++
                      ) ...[
                        Text(
                          _craftsmanshipParagraphs[i],
                          style: GoogleFonts.inter(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: bodySize,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (i != _craftsmanshipParagraphs.length - 1)
                          const SizedBox(height: 22),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              color: AppTheme.surface,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontal,
                      30,
                      horizontal,
                      30,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _stats.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 20,
                        childAspectRatio: Responsive.isDesktop(context)
                            ? 2.2
                            : 2.0,
                      ),
                      itemBuilder: (context, index) {
                        return _StatTile(stat: _stats[index]);
                      },
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              color: AppTheme.surface,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontal,
                      52,
                      horizontal,
                      56,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Ready to Find Your\nPerfect Piece?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            color: AppTheme.onSurface,
                            fontSize: ctaHeadingSize,
                            height: 1.08,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Explore our collection or get in touch with our team to create something uniquely yours',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: bodySize,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 220,
                          child: ElevatedButton(
                            onPressed: () => context.go('/collection'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              'Browse Collection',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: 160,
                          child: OutlinedButton(
                            onPressed: () => context.go('/contact'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.primary),
                              minimumSize: const Size.fromHeight(56),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              backgroundColor: const Color(0xFF090D18),
                            ),
                            child: Text(
                              'Contact Us',
                              style: GoogleFonts.inter(
                                color: AppTheme.onSurface,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
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
    );
  }
}

class _StatTile extends StatelessWidget {
  final _StatData stat;

  const _StatTile({required this.stat});

  @override
  Widget build(BuildContext context) {
    final numberSize = Responsive.value<double>(
      context,
      mobile: 44,
      tablet: 46,
      desktop: 48,
    );
    final labelSize = Responsive.value<double>(
      context,
      mobile: 13,
      tablet: 14,
      desktop: 15,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          stat.value,
          style: GoogleFonts.inter(
            color: AppTheme.primary,
            fontSize: numberSize,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          stat.label,
          style: GoogleFonts.inter(
            color: AppTheme.onSurfaceVariant,
            fontSize: labelSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ValueCard extends StatelessWidget {
  final _ValueData value;

  const _ValueCard({required this.value});

  @override
  Widget build(BuildContext context) {
    final widthFactor = Responsive.value<double>(
      context,
      mobile: 0.92,
      tablet: 0.86,
      desktop: 0.8,
    );
    final minHeight = Responsive.value<double>(
      context,
      mobile: 280,
      tablet: 300,
      desktop: 320,
    );
    final titleSize = Responsive.value<double>(
      context,
      mobile: 24,
      tablet: 28,
      desktop: 30,
    );
    final bodySize = Responsive.value<double>(
      context,
      mobile: 15,
      tablet: 16,
      desktop: 17,
    );

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            border: Border.all(
              color: AppTheme.outlineVariant.withValues(alpha: 0.32),
              width: 0.8,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 38, 20, 38),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value.icon, style: const TextStyle(fontSize: 46)),
              const SizedBox(height: 12),
              Text(
                value.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  color: AppTheme.onSurface,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                value.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: bodySize,
                  height: 1.45,
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

class _ValueData {
  final String icon;
  final String title;
  final String description;

  const _ValueData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _StatData {
  final String value;
  final String label;

  const _StatData({required this.value, required this.label});
}
