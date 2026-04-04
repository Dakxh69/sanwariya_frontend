import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'nav_menu.dart';

class SanwariyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _actionIconColor = Colors.white;

  static const _cartSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <circle cx="9" cy="21" r="1"/>
  <circle cx="20" cy="21" r="1"/>
  <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
</svg>
  ''';

  static const _userSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <circle cx="12" cy="7" r="4"/>
  <path d="M5.5 21a7.5 7.5 0 0 1 13 0"/>
</svg>
  ''';

  static const _menuSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <line x1="4" y1="12" x2="20" y2="12"></line>
  <line x1="4" y1="6" x2="20" y2="6"></line>
  <line x1="4" y1="18" x2="20" y2="18"></line>
</svg>
  ''';

  static const _closeSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <line x1="18" y1="6" x2="6" y2="18"></line>
  <line x1="6" y1="6" x2="18" y2="18"></line>
</svg>
  ''';

  final String currentPath;
  final Color backgroundColor;
  final Color titleColor;
  final bool showMenuOnDesktop;
  final bool showCloseMenuIcon;
  final VoidCallback? onCartPressed;
  final VoidCallback? onUserPressed;
  final VoidCallback? onMenuPressed;

  const SanwariyaAppBar({
    super.key,
    required this.currentPath,
    this.backgroundColor = AppTheme.background,
    this.titleColor = AppTheme.primary,
    this.showMenuOnDesktop = false,
    this.showCloseMenuIcon = false,
    this.onCartPressed,
    this.onUserPressed,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(86);

  void _pushIfNeeded(BuildContext context, String route) {
    if (currentPath == route) return;
    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
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

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      title: ShaderMask(
        shaderCallback: (bounds) {
          return goldGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        blendMode: BlendMode.srcIn,
        child: Text(
          'Sanwariya Imitation',
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white, height: 1.05),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        _CartActionIcon(
          onPressed: onCartPressed ?? () => _pushIfNeeded(context, '/cart'),
        ),
        IconButton(
          icon: SvgPicture.string(
            _userSvg,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              _actionIconColor,
              BlendMode.srcIn,
            ),
          ),
          onPressed: onUserPressed ?? () => _pushIfNeeded(context, '/login'),
        ),
        if (showMenuOnDesktop || !isDesktop)
          IconButton(
            icon: SvgPicture.string(
              showCloseMenuIcon ? _closeSvg : _menuSvg,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                _actionIconColor,
                BlendMode.srcIn,
              ),
            ),
            onPressed:
                onMenuPressed ??
                () => NavMenu.show(context, currentPath: currentPath),
          ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _CartActionIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const _CartActionIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Selector<MockDataProvider, int>(
      selector: (_, provider) => provider.cartCount,
      builder: (context, count, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: SvgPicture.string(
                SanwariyaAppBar._cartSvg,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  SanwariyaAppBar._actionIconColor,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: onPressed,
            ),
            if (count > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: AppTheme.onPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
