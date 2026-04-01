import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_bottom_nav.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GlassBottomNav(currentPath: '/offers'),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'EXCLUSIVE OFFERS',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  foreground: Paint()..shader = const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.onSurface],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Discover exceptional value on our most coveted pieces. Handcrafted brilliance meets curated savings in our Digital Atelier.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Hero Offer Card
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.celebration, color: AppTheme.onPrimary),
                        const SizedBox(width: 8),
                        Text(
                          'LIMITED TIME BRILLIANCE',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '₹10000 OFF',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onPrimary,
                        fontSize: 48,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'On our Heritage Solitaire Collection',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.onPrimary,
                        foregroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Text(
                        'REDEEM OFFER',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),

              // Bento Grid Items
              _buildOfferTile(
                context,
                title: 'Complementary Gold Coin',
                subtitle: 'With every bridal set purchase above ₹2,00,000.',
                label: 'Wedding Special',
                bgColor: AppTheme.surfaceContainer,
              ),
              const SizedBox(height: 24),
              _buildOfferTile(
                context,
                title: '15% Welcome Privilege',
                subtitle: 'Join the inner circle of Sanwariya. Unlock your first-time buyer privilege on your debut masterpiece.',
                label: 'First Purchase',
                bgColor: AppTheme.surfaceContainerLow,
                borderLeft: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildSmallOfferTile(
                      context,
                      icon: Icons.recycling,
                      title: 'Old Gold Exchange',
                      subtitle: '0% deduction on market value.',
                      bgColor: AppTheme.surfaceContainer,
                      borderTop: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSmallOfferTile(
                      context,
                      icon: Icons.group_add,
                      title: 'Refer a Peer',
                      subtitle: 'Earn loyalty points for every successful referral.',
                      bgColor: AppTheme.surfaceContainerHigh,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String label,
    required Color bgColor,
    bool borderLeft = false,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        border: borderLeft ? const Border(left: BorderSide(color: AppTheme.primary, width: 4)) : null,
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.primary,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallOfferTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color bgColor,
    bool borderTop = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: borderTop ? const Border(top: BorderSide(color: AppTheme.primary, width: 2)) : null,
      ),
      padding: const EdgeInsets.all(24),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
