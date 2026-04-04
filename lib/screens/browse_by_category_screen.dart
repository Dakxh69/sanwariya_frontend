import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/sanwariya_app_bar.dart';

class BrowseByCategoryScreen extends StatelessWidget {
  const BrowseByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showBottom = Responsive.showBottomNav(context);
    final hPad = Responsive.horizontalPadding(context);
    final isTabletOrDesktop = Responsive.isTabletOrDesktop(context);
    final headingStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.w900,
      letterSpacing: -1.5,
      height: 1.1,
    );
    final sanwariyaTitleGradient = const LinearGradient(
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
    const categoryTiles = <_CategoryTile>[
      _CategoryTile(
        title: 'Bangles',
        subtitle: '',
        description:
            'Traditional and modern bangles in gold, silver, and precious stones.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBbdk_KYPd5J7wRCOqjmJIB5TN2wnIl3R4bmhOKyeVdKl7Asz32fcoGDkeBj55Y-6jVY5X3tGYreGTXpiPF18y7bokFP2UfK5qrhsjq9Nj1U2QCi0KKsQWv5Wm7lmZ9RGJzuByRGX54qBkCGW6r-_mSBhc9PpvzV1auxN2Fy45E-Z8UxnjA79lh-e-9IzGl87RaScXWfKvuPKhiZwrS2VNHrSMHij0WFXbLRivkWBuMJ7oC8WbEqK3sH_-N7kHlHnLfCf8qF7oKkOKx',
      ),
      _CategoryTile(
        title: 'Bracelets',
        subtitle: '',
        description:
            'Beautiful bracelets that add spohistication to any outfit',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAgIwlt4q6TRCwehKQxr7Umhp8XgL6BLgaAQ_e5UAIKrsYisrdigt0rlIGn_xoSk8Ie6yhIePwh1s1iOIvua3RyLorW8uOiI9lnPvUgQd9dF2nwidT692-MGaIoEppb6yIQoN4KG8emB2b1-SKmgNWknSuUKmfeeBVuEvj4LtzxzWraoyrQWGgZbWibm2pRBkgadgX9IRNyD0SwVF0_WFMhdUXUmypyrJhf-Mf4SJ14YA-dMBoxr7kJMDzEEYsZ18PsZ7b29UFLoJhn',
      ),
      _CategoryTile(
        title: 'Chains',
        subtitle: '',
        description:
            'Refined chain styles crafted for daily wear and occasion styling.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDGhP-MYGVrdupr807j4W9sUY8tB9E2hf1S9GJf7n2gIGeyfcFml2t49UmLbF5jNxZceil0AQRj3bV6oAUElhWaZRmZXSk_QQWJIGwEOSBaRA9nPn1nC86gxirZl-2FptOtzQS8-MY7xONd85nAOETwQlE8_XKaDw4Z6BW-H4Y8H1exEr7TRPz2PEjbjZZSULvtMsTrImYU_K_Ft6Ew_jF7t4geB5slrUm2FsxrLnw9_LJbwCbs_aXx6Ilg7178gm28YPn9Ei3xi416',
      ),
      _CategoryTile(
        title: 'Earrings',
        subtitle: '',
        description:
            'Stunning earrings designed to complement your unique style',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAUQYxfFFo8qEO_4oLjf1UQe1mA6hU8j6Vn0jQ7WrnGl16xjHpmkkHaUO0HJwAw11X08Y1-3iEOCzVAVwBhuZitGuNfhn9ErI8uvty9rUEI2IE16p0YYoA0ze0Q0wmC9yUge3EZpbkZt-pDJm1tDyaMdvZm8J9J7c59D39L88cfQ5Iz0mnc3rce2ewK3ZuL-bGHADeIghyybcfsBjdwzzSUGjaDB3d2ElSm_xQyShZsf5u0GrtCUn3j5ctS67qv1UIZXiA2n_Mwk3qs',
      ),
      _CategoryTile(
        title: 'Necklaces',
        subtitle: '',
        description:
            'Elegant necklaces crafted with precision and adorned with precious gems',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDGhP-MYGVrdupr807j4W9sUY8tB9E2hf1S9GJf7n2gIGeyfcFml2t49UmLbF5jNxZceil0AQRj3bV6oAUElhWaZRmZXSk_QQWJIGwEOSBaRA9nPn1nC86gxirZl-2FptOtzQS8-MY7xONd85nAOETwQlE8_XKaDw4Z6BW-H4Y8H1exEr7TRPz2PEjbjZZSULvtMsTrImYU_K_Ft6Ew_jF7t4geB5slrUm2FsxrLnw9_LJbwCbs_aXx6Ilg7178gm28YPn9Ei3xi416',
      ),
      _CategoryTile(
        title: 'Pendants',
        subtitle: '',
        description:
            'Delicate pendants perfect for layering or wearing solo',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAYDBfSZQTVV76WvccV0vM9eBSgyL1TchCauE5PB4F8Az0poweey8F3stbJT_UfH9P4bjI0DNV5nGQyc48jkmxe6DBe96UmVonhR4SNSD6GCUdEE0hTL14smy2Gj9yt6IyrX9XTumGGPnR-DFP84GmtStElTAXJ1N6kxYuX72R-rdG6EDtmqEhIPMDpiNW9idVwIIFVmMe6aiovhSyonwr2wjXozz8pdzcGsj6ZzdnZQBafG1U6ipdRIbgICc8359-_9364kLNPjBuH',
      ),
      _CategoryTile(
        title: 'Rings',
        subtitle: '',
        description:
            'Exquisite rings for every occasion, from engagement to everyday elegance',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAYDBfSZQTVV76WvccV0vM9eBSgyL1TchCauE5PB4F8Az0poweey8F3stbJT_UfH9P4bjI0DNV5nGQyc48jkmxe6DBe96UmVonhR4SNSD6GCUdEE0hTL14smy2Gj9yt6IyrX9XTumGGPnR-DFP84GmtStElTAXJ1N6kxYuX72R-rdG6EDtmqEhIPMDpiNW9idVwIIFVmMe6aiovhSyonwr2wjXozz8pdzcGsj6ZzdnZQBafG1U6ipdRIbgICc8359-_9364kLNPjBuH',
      ),
      _CategoryTile(
        title: 'New',
        subtitle: '',
        description:
            'Fresh arrivals featuring the newest trends in imitation jewellery.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAgIwlt4q6TRCwehKQxr7Umhp8XgL6BLgaAQ_e5UAIKrsYisrdigt0rlIGn_xoSk8Ie6yhIePwh1s1iOIvua3RyLorW8uOiI9lnPvUgQd9dF2nwidT692-MGaIoEppb6yIQoN4KG8emB2b1-SKmgNWknSuUKmfeeBVuEvj4LtzxzWraoyrQWGgZbWibm2pRBkgadgX9IRNyD0SwVF0_WFMhdUXUmypyrJhf-Mf4SJ14YA-dMBoxr7kJMDzEEYsZ18PsZ7b29UFLoJhn',
      ),
    ];

    return Scaffold(
      bottomNavigationBar: showBottom
          ? const GlassBottomNav(currentPath: '/browse')
          : null,
      backgroundColor: AppTheme.background,
      appBar: const SanwariyaAppBar(currentPath: '/browse'),
      body: SingleChildScrollView(
        padding: hPad.copyWith(top: 48, bottom: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Browse by',
                      style: headingStyle?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return sanwariyaTitleGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        );
                      },
                      blendMode: BlendMode.srcIn,
                      child: Text(
                        'Category',
                        style: headingStyle?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                'Explore our exquisite collection of fine jewellery,carefully curated across different categories',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white, // required for gradient
                ),
              ),
            ),
            const SizedBox(height: 64),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryTiles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (context, index) => _buildBentoItem(
                context: context,
                title: categoryTiles[index].title,
                subtitle: categoryTiles[index].subtitle,
                description: categoryTiles[index].description,
                imageUrl: categoryTiles[index].imageUrl,
                aspectRatio: isTabletOrDesktop ? 3 / 4 : 4 / 5,
              ),
            ),
            const SizedBox(height: 64),
            _buildBottomCta(context, isTabletOrDesktop: isTabletOrDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildBentoItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String description,
    required String imageUrl,
    required double aspectRatio,
  }) {
    return GestureDetector(
      onTap: () => context.push('/collection'),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.background,
            border: Border.all(
              color: AppTheme.outlineVariant.withValues(alpha: 0.16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SizedBox.expand(
                    child: Container(
                      key: ValueKey(imageUrl),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLowest.withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: AppTheme.outline,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.playfairDisplay(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        color: AppTheme.onSurface.withValues(alpha: 0.92),
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCta(
    BuildContext context, {
    required bool isTabletOrDesktop,
  }) {
    final buttonWidth = isTabletOrDesktop ? 220.0 : 170.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 44),
      decoration: BoxDecoration(
        color: AppTheme.background,
        border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: [
          Text(
            'Can\'t Find What You\'re\nLooking For?',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Browse our complete collection or contact\nus for custom designs',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: AppTheme.onSurface.withValues(alpha: 0.9),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 12,
            children: [
              SizedBox(
                width: buttonWidth,
                height: 52,
                child: FilledButton(
                  onPressed: () => context.push('/collection'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'View All Products',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                width: buttonWidth,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => context.push('/contact'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: AppTheme.primary.withValues(alpha: 0.7),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryTile {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  const _CategoryTile({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });
}
