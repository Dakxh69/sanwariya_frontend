import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/glass_bottom_nav.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.horizontalPadding(context);

    return Scaffold(
      bottomNavigationBar: Responsive.showBottomNav(context)
          ? const GlassBottomNav(currentPath: '/track')
          : null,
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
          padding: hPad.copyWith(top: 40, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ATELIER LOGISTICS',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.primary,
                  letterSpacing: 3.0,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Track Your Order',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.onSurface],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Trace the journey of your curated acquisition from our atelier to your hands.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 680 : double.infinity,
                  ),
                  child: Container(
                    color: AppTheme.surfaceContainerLow,
                    padding: const EdgeInsets.all(40),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRACKING NUMBER',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 10,
                                letterSpacing: 3.0,
                                color: AppTheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'ENTER TRACKING NUMBER',
                            hintStyle: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 2.0,
                                  color: AppTheme.outline.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                            filled: true,
                            fillColor: AppTheme.surfaceContainerLowest,
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.outlineVariant,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.primary),
                            ),
                          ),
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(letterSpacing: 2.0),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              backgroundColor: AppTheme.primary,
                              foregroundColor: AppTheme.onPrimary,
                            ),
                            child: Text(
                              'TRACK ORDER',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4.0,
                                    color: AppTheme.onPrimary,
                                  ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        Center(
                          child: Column(
                            children: [
                              Text(
                                'NEED ASSISTANCE?',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      fontSize: 10,
                                      letterSpacing: 2.0,
                                      color: AppTheme.onSurfaceVariant,
                                    ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppTheme.primary.withValues(
                                              alpha: 0.3,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'SUPPORT',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: AppTheme.primary,
                                              letterSpacing: 3.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppTheme.primary.withValues(
                                              alpha: 0.3,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'WHATSAPP',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: AppTheme.primary,
                                              letterSpacing: 3.0,
                                            ),
                                      ),
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
              ),

              const SizedBox(height: 64),

              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildStatusIndicator(
                        context,
                        icon: Icons.inventory_2,
                        title: 'Dispatched',
                        desc:
                            'Your piece has been meticulously inspected and prepared for travel.',
                      ),
                    ),
                    Expanded(
                      child: _buildStatusIndicator(
                        context,
                        icon: Icons.local_shipping,
                        title: 'In Transit',
                        desc:
                            'Securely handled by our premium logistics partners globally.',
                      ),
                    ),
                    Expanded(
                      child: _buildStatusIndicator(
                        context,
                        icon: Icons.handshake,
                        title: 'Delivered',
                        desc: 'The final reveal of your Sanwariya acquisition.',
                      ),
                    ),
                  ],
                )
              else ...[
                _buildStatusIndicator(
                  context,
                  icon: Icons.inventory_2,
                  title: 'Dispatched',
                  desc:
                      'Your piece has been meticulously inspected and prepared for travel.',
                ),
                const SizedBox(height: 32),
                _buildStatusIndicator(
                  context,
                  icon: Icons.local_shipping,
                  title: 'In Transit',
                  desc:
                      'Securely handled by our premium logistics partners globally.',
                ),
                const SizedBox(height: 32),
                _buildStatusIndicator(
                  context,
                  icon: Icons.handshake,
                  title: 'Delivered',
                  desc: 'The final reveal of your Sanwariya acquisition.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primary, size: 40),
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
