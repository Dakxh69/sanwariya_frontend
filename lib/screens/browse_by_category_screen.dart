import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/nav_menu.dart';
import '../widgets/network_image.dart';

class BrowseByCategoryScreen extends StatelessWidget {
  const BrowseByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showBottom = Responsive.showBottomNav(context);
    final hPad = Responsive.horizontalPadding(context);
    final isTabletOrDesktop = Responsive.isTabletOrDesktop(context);

    return Scaffold(
      bottomNavigationBar: showBottom
          ? const GlassBottomNav(currentPath: '/browse')
          : null,
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
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => context.push('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/login'),
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => NavMenu.show(context, currentPath: '/browse'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: hPad.copyWith(top: 48, bottom: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  AppTheme.primary,
                  AppTheme.primaryContainer,
                  AppTheme.primary,
                ],
              ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                'Browse by Category',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Discover the pinnacle of artisanal craftsmanship. Explore our meticulously curated collections across different categories, each piece designed to illuminate your unique radiance.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 64),

            if (isTabletOrDesktop)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildBentoItem(
                          context: context,
                          title: 'Necklaces',
                          subtitle: 'The Signature Collection',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDGhP-MYGVrdupr807j4W9sUY8tB9E2hf1S9GJf7n2gIGeyfcFml2t49UmLbF5jNxZceil0AQRj3bV6oAUElhWaZRmZXSk_QQWJIGwEOSBaRA9nPn1nC86gxirZl-2FptOtzQS8-MY7xONd85nAOETwQlE8_XKaDw4Z6BW-H4Y8H1exEr7TRPz2PEjbjZZSULvtMsTrImYU_K_Ft6Ew_jF7t4geB5slrUm2FsxrLnw9_LJbwCbs_aXx6Ilg7178gm28YPn9Ei3xi416',
                          aspectRatio: 4 / 3,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildBentoItem(
                          context: context,
                          title: 'Bangles',
                          subtitle: 'Handcrafted',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuBbdk_KYPd5J7wRCOqjmJIB5TN2wnIl3R4bmhOKyeVdKl7Asz32fcoGDkeBj55Y-6jVY5X3tGYreGTXpiPF18y7bokFP2UfK5qrhsjq9Nj1U2QCi0KKsQWv5Wm7lmZ9RGJzuByRGX54qBkCGW6r-_mSBhc9PpvzV1auxN2Fy45E-Z8UxnjA79lh-e-9IzGl87RaScXWfKvuPKhiZwrS2VNHrSMHij0WFXbLRivkWBuMJ7oC8WbEqK3sH_-N7kHlHnLfCf8qF7oKkOKx',
                          aspectRatio: 4 / 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBentoItem(
                          context: context,
                          title: 'Earrings',
                          subtitle: '',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAUQYxfFFo8qEO_4oLjf1UQe1mA6hU8j6Vn0jQ7WrnGl16xjHpmkkHaUO0HJwAw11X08Y1-3iEOCzVAVwBhuZitGuNfhn9ErI8uvty9rUEI2IE16p0YYoA0ze0Q0wmC9yUge3EZpbkZt-pDJm1tDyaMdvZm8J9J7c59D39L88cfQ5Iz0mnc3rce2ewK3ZuL-bGHADeIghyybcfsBjdwzzSUGjaDB3d2ElSm_xQyShZsf5u0GrtCUn3j5ctS67qv1UIZXiA2n_Mwk3qs',
                          aspectRatio: 4 / 3,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildBentoItem(
                          context: context,
                          title: 'Rings',
                          subtitle: 'Timeless Vows',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAYDBfSZQTVV76WvccV0vM9eBSgyL1TchCauE5PB4F8Az0poweey8F3stbJT_UfH9P4bjI0DNV5nGQyc48jkmxe6DBe96UmVonhR4SNSD6GCUdEE0hTL14smy2Gj9yt6IyrX9XTumGGPnR-DFP84GmtStElTAXJ1N6kxYuX72R-rdG6EDtmqEhIPMDpiNW9idVwIIFVmMe6aiovhSyonwr2wjXozz8pdzcGsj6ZzdnZQBafG1U6ipdRIbgICc8359-_9364kLNPjBuH',
                          aspectRatio: 4 / 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildBentoItem(
                    context: context,
                    title: 'Bridal Sets',
                    subtitle: '',
                    aspectRatio: 16 / 5,
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAgIwlt4q6TRCwehKQxr7Umhp8XgL6BLgaAQ_e5UAIKrsYisrdigt0rlIGn_xoSk8Ie6yhIePwh1s1iOIvua3RyLorW8uOiI9lnPvUgQd9dF2nwidT692-MGaIoEppb6yIQoN4KG8emB2b1-SKmgNWknSuUKmfeeBVuEvj4LtzxzWraoyrQWGgZbWibm2pRBkgadgX9IRNyD0SwVF0_WFMhdUXUmypyrJhf-Mf4SJ14YA-dMBoxr7kJMDzEEYsZ18PsZ7b29UFLoJhn',
                  ),
                ],
              )
            else
              Column(
                children: [
                  _buildBentoItem(
                    context: context,
                    title: 'Necklaces',
                    subtitle: 'The Signature Collection',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDGhP-MYGVrdupr807j4W9sUY8tB9E2hf1S9GJf7n2gIGeyfcFml2t49UmLbF5jNxZceil0AQRj3bV6oAUElhWaZRmZXSk_QQWJIGwEOSBaRA9nPn1nC86gxirZl-2FptOtzQS8-MY7xONd85nAOETwQlE8_XKaDw4Z6BW-H4Y8H1exEr7TRPz2PEjbjZZSULvtMsTrImYU_K_Ft6Ew_jF7t4geB5slrUm2FsxrLnw9_LJbwCbs_aXx6Ilg7178gm28YPn9Ei3xi416',
                    aspectRatio: 16 / 9,
                  ),
                  const SizedBox(height: 24),
                  _buildBentoItem(
                    context: context,
                    title: 'Bangles',
                    subtitle: 'Handcrafted',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBbdk_KYPd5J7wRCOqjmJIB5TN2wnIl3R4bmhOKyeVdKl7Asz32fcoGDkeBj55Y-6jVY5X3tGYreGTXpiPF18y7bokFP2UfK5qrhsjq9Nj1U2QCi0KKsQWv5Wm7lmZ9RGJzuByRGX54qBkCGW6r-_mSBhc9PpvzV1auxN2Fy45E-Z8UxnjA79lh-e-9IzGl87RaScXWfKvuPKhiZwrS2VNHrSMHij0WFXbLRivkWBuMJ7oC8WbEqK3sH_-N7kHlHnLfCf8qF7oKkOKx',
                    aspectRatio: 16 / 9,
                  ),
                  const SizedBox(height: 24),
                  _buildBentoItem(
                    context: context,
                    title: 'Earrings',
                    subtitle: '',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAUQYxfFFo8qEO_4oLjf1UQe1mA6hU8j6Vn0jQ7WrnGl16xjHpmkkHaUO0HJwAw11X08Y1-3iEOCzVAVwBhuZitGuNfhn9ErI8uvty9rUEI2IE16p0YYoA0ze0Q0wmC9yUge3EZpbkZt-pDJm1tDyaMdvZm8J9J7c59D39L88cfQ5Iz0mnc3rce2ewK3ZuL-bGHADeIghyybcfsBjdwzzSUGjaDB3d2ElSm_xQyShZsf5u0GrtCUn3j5ctS67qv1UIZXiA2n_Mwk3qs',
                    aspectRatio: 16 / 9,
                  ),
                  const SizedBox(height: 24),
                  _buildBentoItem(
                    context: context,
                    title: 'Rings',
                    subtitle: 'Timeless Vows',
                    imageUrl:
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAYDBfSZQTVV76WvccV0vM9eBSgyL1TchCauE5PB4F8Az0poweey8F3stbJT_UfH9P4bjI0DNV5nGQyc48jkmxe6DBe96UmVonhR4SNSD6GCUdEE0hTL14smy2Gj9yt6IyrX9XTumGGPnR-DFP84GmtStElTAXJ1N6kxYuX72R-rdG6EDtmqEhIPMDpiNW9idVwIIFVmMe6aiovhSyonwr2wjXozz8pdzcGsj6ZzdnZQBafG1U6ipdRIbgICc8359-_9364kLNPjBuH',
                    aspectRatio: 16 / 9,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBentoItem(
                          context: context,
                          title: 'Bridal Sets',
                          subtitle: '',
                          aspectRatio: 16 / 9,
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAgIwlt4q6TRCwehKQxr7Umhp8XgL6BLgaAQ_e5UAIKrsYisrdigt0rlIGn_xoSk8Ie6yhIePwh1s1iOIvua3RyLorW8uOiI9lnPvUgQd9dF2nwidT692-MGaIoEppb6yIQoN4KG8emB2b1-SKmgNWknSuUKmfeeBVuEvj4LtzxzWraoyrQWGgZbWibm2pRBkgadgX9IRNyD0SwVF0_WFMhdUXUmypyrJhf-Mf4SJ14YA-dMBoxr7kJMDzEEYsZ18PsZ7b29UFLoJhn',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 24),
            _buildCustomAtelier(context),

            const SizedBox(height: 96),
            const Divider(color: AppTheme.outlineVariant),
            const SizedBox(height: 64),
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppTheme.primaryContainer,
                    size: 48,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '"Jewelry is not just an accessory; it is a fragment of the soul brought to light."',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(width: 48, height: 1, color: AppTheme.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBentoItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imageUrl,
    required double aspectRatio,
  }) {
    return GestureDetector(
      onTap: () => context.push('/collection'),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          color: AppTheme.surfaceContainer,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: 0.7,
                child: AestheticNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.zero,
                ),
              ),

              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.surfaceContainerLowest,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.6],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              Positioned(
                bottom: 32,
                left: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.primary,
                          letterSpacing: 4.0,
                          fontSize: 10,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
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

  Widget _buildCustomAtelier(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/contact'),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: AppTheme.surfaceContainerLow,
          padding: const EdgeInsets.all(32),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.outlineVariant.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppTheme.primary,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Custom Atelier',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'CO-CREATE YOUR MASTERPIECE',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    letterSpacing: 3.0,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.only(bottom: 4),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.primary)),
                  ),
                  child: Text(
                    'REQUEST APPOINTMENT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                      letterSpacing: 2.0,
                      fontSize: 10,
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
