import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class GlassBottomNav extends StatelessWidget {
  final String currentPath;

  const GlassBottomNav({super.key, required this.currentPath});

  static const _glassDecoration = BoxDecoration(
    color: Color(0x99353534),
    boxShadow: [
      BoxShadow(color: Colors.black54, blurRadius: 48, offset: Offset(0, -24)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 80,
            decoration: _glassDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavItem(
                  icon: Icons.home,
                  label: 'Home',
                  isActive: currentPath == '/',
                  onTap: () {
                    if (currentPath != '/') context.go('/');
                  },
                ),
                _NavItem(
                  icon: Icons.storefront,
                  label: 'Shop',
                  isActive: currentPath == '/collection',
                  onTap: () {
                    if (currentPath != '/collection')
                      context.push('/collection');
                  },
                ),
                _NavItem(
                  icon: Icons.grid_view,
                  label: 'Categories',
                  isActive: currentPath == '/browse',
                  onTap: () {
                    if (currentPath != '/browse') context.push('/browse');
                  },
                ),
                _NavItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Cart',
                  isActive: currentPath == '/cart',
                  onTap: () {
                    if (currentPath != '/cart') context.push('/cart');
                  },
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  label: 'Account',
                  isActive: currentPath == '/login',
                  onTap: () => context.push('/login'),
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
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  final String _upperLabel;

  _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : _upperLabel = label.toUpperCase();

  static const _activeBorder = BoxDecoration(
    border: Border(top: BorderSide(color: AppTheme.primary, width: 2)),
  );
  static const _inactiveBorder = BoxDecoration(
    border: Border(top: BorderSide(color: Colors.transparent, width: 2)),
  );

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.primary : const Color(0x99F5E9C9);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: isActive ? _activeBorder : _inactiveBorder,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              _upperLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontSize: 10,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
