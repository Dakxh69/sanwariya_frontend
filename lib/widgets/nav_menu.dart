import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';

class NavMenu extends StatelessWidget {
  final String currentPath;

  const NavMenu({super.key, required this.currentPath});

  static Future<void> show(BuildContext context, {String currentPath = '/'}) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: true,
      barrierLabel: 'Close Menu',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return NavMenu(currentPath: currentPath);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface.withValues(alpha: 0.95),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Sanwariya\nImitation',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.primary,
                            fontFamily: 'Noto Serif',
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined, color: AppTheme.onSurface),
                            onPressed: () {
                              Navigator.pop(context);
                              context.push('/cart');
                            },
                          ),
                          Consumer<MockDataProvider>(
                            builder: (context, provider, child) {
                              if (provider.cartCount == 0) return const SizedBox.shrink();
                              return Positioned(
                                right: 6,
                                top: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                                  child: Text(
                                    provider.cartCount.toString(),
                                    style: const TextStyle(color: AppTheme.onPrimary, fontSize: 10, fontWeight: FontWeight.w900),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_outline, color: AppTheme.onSurface),
                        onPressed: () {
                          Navigator.pop(context);
                          context.push('/login');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppTheme.onSurface),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppTheme.surfaceContainerHighest, thickness: 1),
            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                children: [
                  _MenuItem(title: 'Home', path: '/', currentPath: currentPath),
                  _MenuItem(title: 'Shop', path: '/collection', currentPath: currentPath),
                  _MenuItem(title: 'Categories', path: '/browse', currentPath: currentPath),
                  _MenuItem(title: 'Offers', path: '/offers', currentPath: currentPath),
                  _MenuItem(title: 'Track Order', path: '/track', currentPath: currentPath),
                  _MenuItem(title: 'About', path: '/about', currentPath: currentPath),
                  _MenuItem(title: 'Contact Us', path: '/contact', currentPath: currentPath),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String path;
  final String currentPath;

  const _MenuItem({
    required this.title,
    required this.path,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentPath == path;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (!isActive) {
            context.push(path);
          }
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isActive ? AppTheme.primary : AppTheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
