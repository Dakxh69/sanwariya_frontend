import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    final heroH = Responsive.value<double>(
      context,
      mobile: 400,
      tablet: 480,
      desktop: 520,
    );
    final isTabletOrDesktop = Responsive.isTabletOrDesktop(context);
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/')),
        title: Text(
          'SANWARIYA',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppTheme.primary,
            letterSpacing: 4.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: heroH,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.surfaceContainerLow,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppTheme.surfaceContainerLowest.withValues(
                            alpha: 0.8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: hPad.copyWith(top: 32, bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppTheme.primary,
                                letterSpacing: 4.0,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'About Sanwariya',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 48,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 4,
                          width: 64,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '"Crafting timeless elegance with an unyielding commitment to quality. We illuminate your unique story through the artistry of jewelry."',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: hPad.copyWith(top: 64, bottom: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Story',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Sanwariya was born in the heart of a small workshop, fueled by a singular passion: to make the exquisite craftsmanship of high-end jewelry accessible to those who value artistry over labels.\n\nWhat began as a personal quest for the perfect balance of tradition and modernity has evolved into a global brand. Our origins are rooted in the meticulous techniques of master craftsmen, whose secrets have been passed down through generations.\n\nEvery piece we create is a testament to this journey—a bridge between the heritage of the past and the bold expression of the future.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              color: AppTheme.surfaceContainerLow,
              width: double.infinity,
              padding: hPad.copyWith(top: 64, bottom: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Our Values',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'THE PILLARS OF OUR CRAFTSMANSHIP',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 48),
                  if (isTabletOrDesktop)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildValueCard(
                                context,
                                icon: Icons.diamond_outlined,
                                title: 'Quality',
                                desc:
                                    'We never compromise. Meticulous attention to detail is not a goal; it is our standard.',
                                bgColor: AppTheme.surfaceContainer,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildValueCard(
                                context,
                                icon: Icons.lightbulb_outline,
                                title: 'Innovation',
                                desc:
                                    'Blending traditional craftsmanship with contemporary, modern design to create future classics.',
                                bgColor: AppTheme.surfaceContainerLowest,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildValueCard(
                                context,
                                icon: Icons.handshake_outlined,
                                title: 'Trust',
                                desc:
                                    'Transparency and authenticity in every transaction, backed by world-class customer service.',
                                bgColor: AppTheme.surfaceContainer,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildValueCard(
                                context,
                                icon: Icons.eco_outlined,
                                title: 'Sustainability',
                                desc:
                                    'Ethical sourcing is the heartbeat of our supply chain. We believe luxury should never come at the cost of our planet.',
                                bgColor: AppTheme.primary,
                                textColor: AppTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildValueCard(
                          context,
                          icon: Icons.diamond_outlined,
                          title: 'Quality',
                          desc:
                              'We never compromise. Meticulous attention to detail is not a goal; it is our standard.',
                          bgColor: AppTheme.surfaceContainer,
                        ),
                        const SizedBox(height: 24),
                        _buildValueCard(
                          context,
                          icon: Icons.lightbulb_outline,
                          title: 'Innovation',
                          desc:
                              'Blending traditional craftsmanship with contemporary, modern design to create future classics.',
                          bgColor: AppTheme.surfaceContainerLowest,
                        ),
                        const SizedBox(height: 24),
                        _buildValueCard(
                          context,
                          icon: Icons.handshake_outlined,
                          title: 'Trust',
                          desc:
                              'Transparency and authenticity in every transaction, backed by world-class customer service.',
                          bgColor: AppTheme.surfaceContainer,
                        ),
                        const SizedBox(height: 24),
                        _buildValueCard(
                          context,
                          icon: Icons.eco_outlined,
                          title: 'Sustainability',
                          desc:
                              'Ethical sourcing is the heartbeat of our supply chain. We believe luxury should never come at the cost of our planet.',
                          bgColor: AppTheme.primary,
                          textColor: AppTheme.onPrimary,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            Padding(
              padding: hPad.copyWith(top: 64, bottom: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Experience the Atelier',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Step into our world and discover pieces that aren\'t just worn, but lived in. Your journey with SANWARIYA is just beginning.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/collection'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.onPrimary,
                      ),
                      child: Text(
                        'EXPLORE COLLECTIONS',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4.0,
                          color: AppTheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String desc,
    required Color bgColor,
    Color? textColor,
  }) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor ?? AppTheme.primary, size: 40),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor ?? AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor != null
                  ? textColor.withValues(alpha: 0.8)
                  : AppTheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
