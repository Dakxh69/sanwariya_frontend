import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/network_image.dart';
import '../widgets/glass_bottom_nav.dart';
import '../widgets/sanwariya_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.horizontalPadding(context);

    return Scaffold(
      bottomNavigationBar: Responsive.showBottomNav(context)
          ? const GlassBottomNav(currentPath: '/cart')
          : null,
      backgroundColor: AppTheme.surface,
      appBar: const SanwariyaAppBar(currentPath: '/cart'),
      body: Consumer<MockDataProvider>(
        builder: (context, provider, _) {
          final cartItems = provider.cartItems;
          if (cartItems.isEmpty) {
            return _buildEmptyState(context);
          }

          final subtotal = cartItems.fold(
            0.0,
            (sum, item) => sum + (item.product.price * item.quantity),
          );
          final shipping = subtotal >= 50000 ? 0.0 : 500.0;
          final total = subtotal + shipping;

          return SingleChildScrollView(
            padding: hPad.copyWith(top: 32, bottom: 32),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: RepaintBoundary(
                          child: _buildCartList(context, cartItems),
                        ),
                      ),
                      const SizedBox(width: 48),

                      SizedBox(
                        width: 380,
                        child: RepaintBoundary(
                          child: _buildOrderSummary(
                            context,
                            subtotal,
                            shipping,
                            total,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RepaintBoundary(
                        child: _buildCartList(context, cartItems),
                      ),
                      const SizedBox(height: 64),
                      RepaintBoundary(
                        child: _buildOrderSummary(
                          context,
                          subtotal,
                          shipping,
                          total,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final contentPadding = Responsive.value<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 44),
      tablet: const EdgeInsets.symmetric(horizontal: 92),
      desktop: const EdgeInsets.symmetric(horizontal: 200),
    );

    final topPadding = Responsive.value<double>(
      context,
      mobile: 84,
      tablet: 100,
      desktop: 116,
    );

    final titleSize = Responsive.value<double>(
      context,
      mobile: 42,
      tablet: 48,
      desktop: 52,
    );

    final descriptionSize = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 18,
      desktop: 19,
    );

    return Container(
      color: AppTheme.surface,
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: contentPadding.copyWith(top: topPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.string(
                  '''
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/>
  <path d="M3 6h18"/>
  <path d="M16 10a4 4 0 0 1-8 0"/>
</svg>
                  ''',
                  width: 64,
                  height: 64,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFD4AF37),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Cart is Empty',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    textStyle: Theme.of(context).textTheme.displaySmall
                        ?.copyWith(
                          fontSize: 36,
                          color: AppTheme.onSurface,
                          height: 1,
                        ),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Text(
                    "Looks like you haven't added any items to your cart yet.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(
                            color: AppTheme.onSurface,
                            height: 1.4,
                            fontSize: descriptionSize,
                          ),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () => context.go('/collection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'Start Shopping',
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildCartList(BuildContext context, List<CartItem> cartItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shopping Cart',
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.displaySmall,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 48),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 32),
          itemBuilder: (context, index) =>
              RepaintBoundary(child: _buildCartItem(context, cartItems[index])),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    double subtotal,
    double shipping,
    double total,
  ) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: AppTheme.surfaceContainerLowest),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.bold,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 28),
          _buildSummaryRow(
            context,
            'Subtotal',
            '₹${subtotal.toStringAsFixed(0)}',
            valueColor: AppTheme.onSurface,
          ),
          const SizedBox(height: 20),
          _buildSummaryRow(
            context,
            'Shipping',
            shipping == 0 ? 'FREE' : '₹${shipping.toStringAsFixed(0)}',
            valueColor: AppTheme.onSurface,
          ),
          const SizedBox(height: 14),
          Text(
            'Free shipping on orders above ₹50,000',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.primary),
          ),
          const SizedBox(height: 18),
          Divider(color: AppTheme.outlineVariant.withValues(alpha: 0.8)),
          const SizedBox(height: 20),
          _buildSummaryRow(
            context,
            'Total',
            '₹${total.toStringAsFixed(0)}',
            titleStyle: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            valueStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primary),
                minimumSize: const Size.fromHeight(56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                'Continue Shopping',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    String value, {
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            textStyle:
                titleStyle ??
                Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            textStyle:
                valueStyle ??
                Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: valueColor ?? AppTheme.onSurface,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final isDesktop = Responsive.isDesktop(context);
    final imageSize = isDesktop ? 128.0 : 104.0;

    return Container(
      padding: EdgeInsets.all(isDesktop ? 20 : 14),
      decoration: BoxDecoration(color: AppTheme.surfaceContainerLowest),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            color: AppTheme.surfaceContainer,
            child: AestheticNetworkImage(
              imageUrl: item.product.imageUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.zero,
            ),
          ),
          SizedBox(width: isDesktop ? 24 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '22K • 15g',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppTheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item.product.price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isDesktop ? 16 : 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        border: Border.all(color: AppTheme.outlineVariant),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildQtyActionButton(
                            icon: Icons.remove,
                            onPressed: () {
                              context.read<MockDataProvider>().updateQuantity(
                                item.product.id,
                                -1,
                              );
                            },
                          ),
                          Container(
                            width: isDesktop ? 52 : 44,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppTheme.outlineVariant,
                                ),
                                right: BorderSide(
                                  color: AppTheme.outlineVariant,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: isDesktop ? 10 : 8,
                            ),
                            child: Text(
                              item.quantity.toString(),
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          _buildQtyActionButton(
                            icon: Icons.add,
                            onPressed: () {
                              context.read<MockDataProvider>().updateQuantity(
                                item.product.id,
                                1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        context.read<MockDataProvider>().removeFromCart(
                          item.product.id,
                        );
                      },
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 42,
      height: 42,
      child: IconButton(
        onPressed: onPressed,
        splashRadius: 18,
        icon: Icon(icon, size: 18, color: AppTheme.onSurface),
      ),
    );
  }
}
