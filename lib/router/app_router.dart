import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/browse_by_category_screen.dart';
import '../screens/shop_collection_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';

import '../screens/offers_screen.dart';
import '../screens/track_order_screen.dart';
import '../screens/contact_us_screen.dart';
import '../screens/about_us_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/browse',
        builder: (context, state) => const BrowseByCategoryScreen(),
      ),
      GoRoute(
        path: '/collection',
        builder: (context, state) {
          return const ShopCollectionScreen();
        },
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailScreen(productId: id);
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/offers',
        builder: (context, state) => const OffersScreen(),
      ),
      GoRoute(
        path: '/track',
        builder: (context, state) => const TrackOrderScreen(),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutUsScreen(),
      ),
    ],
  );
}
