import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class GlassBottomNav extends StatelessWidget {
  final String currentPath;

  const GlassBottomNav({super.key, required this.currentPath});

  static const _navHeight = 80.0;
  static const _iconColor = Color(0xFFD4AF37);

  static const _homeSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <path d="M3 12l9-9 9 9v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
</svg>
  ''';

  static const _plusSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <circle cx="12" cy="12" r="10"/>
  <path d="M8 12h8"/>
  <path d="M12 8v8"/>
</svg>
  ''';

  static const _gridSvg = '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <rect x="3" y="3" width="7" height="7"/>
  <rect x="14" y="3" width="7" height="7"/>
  <rect x="14" y="14" width="7" height="7"/>
  <rect x="3" y="14" width="7" height="7"/>
</svg>
  ''';

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

  static const _glassDecoration = BoxDecoration(
    color: Color(0xFF0E0E12),
    border: Border(top: BorderSide(color: _iconColor, width: 1)),
  );

  void _navigate(BuildContext context, String route, {bool replace = false}) {
    if (currentPath == route) {
      return;
    }
    if (replace) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: _navHeight,
            decoration: _glassDecoration,
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    onTap: () => _navigate(context, '/', replace: true),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.add_circle_outline,
                    label: 'Shop',
                    onTap: () => _navigate(context, '/collection'),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.grid_view_outlined,
                    label: 'Categories',
                    onTap: () => _navigate(context, '/browse'),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Cart',
                    onTap: () => _navigate(context, '/cart'),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.person_outline,
                    label: 'Account',
                    onTap: () => _navigate(context, '/login'),
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

class _NavItem extends StatelessWidget {
  static const _itemColor = GlassBottomNav._iconColor;

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  String _resolveIconSvg() {
    if (icon == Icons.home_outlined) {
      return GlassBottomNav._homeSvg;
    }
    if (icon == Icons.add_circle_outline) {
      return GlassBottomNav._plusSvg;
    }
    if (icon == Icons.grid_view_outlined) {
      return GlassBottomNav._gridSvg;
    }
    if (icon == Icons.shopping_cart_outlined) {
      return GlassBottomNav._cartSvg;
    }
    return GlassBottomNav._userSvg;
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.string(
              _resolveIconSvg(),
              width: 26,
              height: 26,
              colorFilter: const ColorFilter.mode(_itemColor, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: labelStyle?.copyWith(
                color: _itemColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
