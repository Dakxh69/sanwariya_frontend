import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/network_image.dart';
import '../widgets/nav_menu.dart';
import '../widgets/glass_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'SANWARIYA',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primary,
                letterSpacing: 4.0,
                fontFamily: 'Noto Serif',
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => context.push('/cart'),
            color: AppTheme.onSurface,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/login'),
            color: AppTheme.onSurface,
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => NavMenu.show(context, currentPath: '/'),
            color: AppTheme.onSurface,
          ),
        ],
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _ShopByCategorySection(),
            const _ArtisanChoiceSection(),
            const _NewsletterSection(),
            const _AestheticQuote(),
            // Bottom padding for Glassmorphism nav
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const GlassBottomNav(currentPath: '/'),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 751,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image with grayscale effect roughly replicated by ColorFilter blending if needed,
          // but direct image works too.
          const AestheticNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1599643477877-530eb83abc8e?auto=format&fit=crop&q=80&w=1200',
            fit: BoxFit.cover,
            borderRadius: BorderRadius.zero,
          ),
          // Gradients
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.background, Colors.transparent],
                stops: [0.0, 0.4],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Content
          Positioned(
            left: 32,
            right: 32,
            bottom: 64,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COLLECTION 2024',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.primary,
                        letterSpacing: 3.0,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'The Gilded\nCanvas',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppTheme.onSurface,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () => context.push('/collection'),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Text(
                      'DISCOVER MORE',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimary,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ShopByCategorySection extends StatelessWidget {
  const _ShopByCategorySection();

  @override
  Widget build(BuildContext context) {
    // API_HOOK: Replace these with your Category models from Provider
    final List<Map<String, String>> categories = [
      {'name': 'BANGLES', 'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuABps_4EMpvS9QxWYFvxAN0TWPxhXLnw7cVCrB-nXQtyzb-i7cTavXk5JPSaqwLZkW1XjZuySntjwhNUtMQNLjpNRm_Z8re6cCYZdPzSGfNDv_v6_WnzuAzJKrrAjiDusSGS9oLvttiRbNFGSmbnAP9OuqVvn8NAsOgIgZQVpSZbzKeEqFJIFCJcSf7b71h6DYWHu0Die311byTGyxyOEPmu9SxwniRID2OoswBBEi4XneWB_x0vGFsj5XO8Bo94pcuIXX69RoDeuL7'},
      {'name': 'BRACELETS', 'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDsJ2N_5xrKbaB0Bl-J-a36RArEQHzMKC4ylPfnsc0_9IPz_uIa0wm3DTwiDUEclqRRloEa7lSH-K_WDl9EZ1v1iaWMdGiAOqT4cKDyld1dXu0SvvOU01yBH3JgfODkG2TdlYINwS6EtNodKx_yWpvLkzVL0Bui5qZGclXXJiQ0knTOiI0fHp23l3KmRZe5QvBZVAlkEpHPBBWPDw080oR9bd11o6CEgnHPfZdYXpnI70qQOx8jLah9Qk3wQsn9ec3yyG7ZjlFjmX0e'},
      {'name': 'CHAINS', 'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4bly7_ySQoVOTdlnCzL3tn_zI160jgKSkvNafqk6vrTM3XREHcOzMy7tCEJ5_vilV2BPUbEGq3RFVBhY9_rpkt9di0x0FuLK4XLispW9RFP2WXmHCMGS1hq92HweFEvaVp7cf0hhUZkUaN2affq7sJMY-rKc0ihHmkG3A9_Fv4u3y3V1t8KytQcQ8yxZVwlYljEKj7zXo3cjqBSY95fkQYK3RlFG73H9uzp6B9c4GPmU-qS4BfM5KD6F85IFdLTMryQSFuqMzdWxi'},
      {'name': 'PENDANTS', 'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDuQMsdsZ7Suv7D0L9mhTIp88X_1UZXEExFJWQbyWgQLP9OBJcJe1fLIcK0LyjWuERzd2yzMdalJjJY3NDv3eMniMixQKbj0XNXAKnHtTLdDIMgjbaJE3WmpXw1lYvInTmUpGDF-rGbWZHib_BRVYtcLch_KS0B6N1zgl9ylaQztRlhTmSsi51pmT_4PlCOlaRp23zioQ_R0o7kSlxr4X9BgCjh7cfQMDZyS48c_22oh5nbZ_tXNI-meRRdazCaIBHQs2f6sYykdsdK'},
    ];

    return Container(
      padding: const EdgeInsets.only(top: 80, bottom: 40),
      color: AppTheme.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'Shop by Category',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push('/browse'),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppTheme.primary, width: 1)),
                    ),
                    child: Text(
                      'VIEW ALL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.primary,
                            letterSpacing: 2.0,
                            fontSize: 10,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => context.push('/collection'),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Column(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.outlineVariant, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AestheticNetworkImage(
                              imageUrl: categories[index]['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          categories[index]['name']!,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.onSurface.withValues(alpha: 0.8),
                                fontSize: 10,
                                letterSpacing: 2.0,
                              ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtisanChoiceSection extends StatelessWidget {
  const _ArtisanChoiceSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THE SIGNATURE EDIT',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.primaryContainer,
                        fontSize: 10,
                        letterSpacing: 4.0,
                      ),
                ),
                const SizedBox(height: 12),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.onSurface],
                  ).createShader(bounds),
                  child: Text(
                    'Artisan\'s Choice',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              color: AppTheme.surfaceContainer,
              // AspectRatio 3/4
              width: double.infinity,
              height: MediaQuery.of(context).size.width * (4 / 3) - 48,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const AestheticNetworkImage(
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDuDGk451hh4-yQU_g7Z4h1yGV5yuMC22TikcojBth2yu0Z70i0d92x7X00jE7kRboOnEEWuW7jWBP1lfLYLxBC7CBBya_JGYz6dSttLUOGxIK8J945XgKW9KKlJJAlPlAqYLNDRTnuYCKkmpZEMZS1nKGUIB-NnVLffiXI71ETGV5xQX9EIR43nR1QVI-M0bXY9__ev-PXLq_YBEJzrZRGozBEmKc0gN-62hVImValxku90a8elaAOChxvPnLcQWaUlCh6Glzxkpj5',
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.zero,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.surfaceContainerLowest, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.5],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    left: 32,
                    right: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temple Heirloom Set',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Hand-engraved motifs inspired by Vedic architecture.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.onSurface.withValues(alpha: 0.6),
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                        const SizedBox(height: 24),
                        OutlinedButton(
                          onPressed: () => context.push('/contact'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primary),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size.fromHeight(50),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text(
                            'INQUIRE NOW',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppTheme.primary,
                                  letterSpacing: 2.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NewsletterSection extends StatelessWidget {
  const _NewsletterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.1))),
      ),
      child: Column(
        children: [
          Text(
            'Refine Your Style',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Join our inner circle for exclusive previews of upcoming limited collections and private atelier events.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurface.withValues(alpha: 0.6),
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 48),
          TextField(
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onSurface),
            decoration: InputDecoration(
              hintText: 'EMAIL ADDRESS',
              hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.outlineVariant,
                    letterSpacing: 2.0,
                    fontSize: 10,
                  ),
              filled: true,
              fillColor: AppTheme.surfaceContainerLowest,
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.outline)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.onSurface,
              foregroundColor: AppTheme.surface,
              minimumSize: const Size.fromHeight(56),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Text(
              'SUBSCRIBE',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AestheticQuote extends StatelessWidget {
  const _AestheticQuote();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Text(
            '“',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primaryContainer,
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adornment is a reflection of the inner soul, crafted in gold.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.onSurface.withValues(alpha: 0.4),
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}
