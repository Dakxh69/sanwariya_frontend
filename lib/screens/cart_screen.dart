import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/mock_data_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/network_image.dart';
import '../widgets/nav_menu.dart';
import '../widgets/glass_bottom_nav.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // API_HOOK: Replace mock cart items with real session data
    final cartItems = context.watch<MockDataProvider>().cartItems;
    final subtotal = cartItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
    final tax = subtotal * 0.18; // 18% GST estimate
    final total = subtotal + tax;

    return Scaffold(
      bottomNavigationBar: const GlassBottomNav(currentPath: '/cart'),
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/')),
        title: Text(
          'SANWARIYA',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primary,
                letterSpacing: 3.0,
                fontFamily: 'Noto Serif',
              ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.menu), onPressed: () => NavMenu.show(context, currentPath: '/cart')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shopping Cart',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),

            if (cartItems.isEmpty)
              const Center(child: Text('Your Cart is Empty.'))
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 32),
                itemBuilder: (context, index) {
                  return _buildCartItem(context, cartItems[index]);
                },
              ),

            const SizedBox(height: 64),
            
            // Guarantees
            Row(
              children: [
                const Icon(Icons.verified, color: AppTheme.primary, size: 20),
                const SizedBox(width: 16),
                Text(
                  'LIFETIME AUTHENTICITY GUARANTEE',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.outlineVariant,
                        letterSpacing: 2.0,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.local_shipping, color: AppTheme.primary, size: 20),
                const SizedBox(width: 16),
                Text(
                  'INSURED WHITE-GLOVE DELIVERY',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.outlineVariant,
                        letterSpacing: 2.0,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
            
            const SizedBox(height: 64),

            // Summary
            Container(
              color: AppTheme.surfaceContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        _buildSummaryRow(context, 'Subtotal', '₹${subtotal.toStringAsFixed(0)}'),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SHIPPING', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline, letterSpacing: 2.0)),
                            Text('FREE', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary, letterSpacing: 2.0)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(context, 'Estimated Tax', '₹${tax.toStringAsFixed(0)}'),
                      ],
                    ),
                  ),
                  
                  // Total Strip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    color: AppTheme.surfaceContainerHigh,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        Text('₹${total.toStringAsFixed(0)}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        // Checkout Actions
                        // API_HOOK: onPressed → POST /api/orders/create with cartItems, userId, address
                        // On success, clear cart and navigate to order confirmation screen
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.primary, AppTheme.primaryContainer],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            ),
                            child: Text(
                              'PROCEED TO CHECKOUT',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onPrimary, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () => context.go('/'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primary),
                            minimumSize: const Size.fromHeight(56),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text(
                            'CONTINUE SHOPPING',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        const Divider(color: AppTheme.outlineVariant),
                        const SizedBox(height: 24),
                        
                        // Promo Code
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'PROMO CODE',
                            hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline.withValues(alpha: 0.4), letterSpacing: 2.0),
                            filled: true,
                            fillColor: AppTheme.surfaceContainerLowest,
                            suffixIcon: TextButton(
                              onPressed: () {},
                              child: Text(
                                'APPLY',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold),
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.outline)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                          ),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 2.0),
                        ),
                      ],
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

  Widget _buildSummaryRow(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline, letterSpacing: 2.0),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              color: AppTheme.surfaceContainer,
              child: AestheticNetworkImage(
                imageUrl: item.product.imageUrl,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.zero,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '22K • 15G',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppTheme.outline,
                                    letterSpacing: 2.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${item.product.price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          border: Border(bottom: BorderSide(color: AppTheme.outlineVariant)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<MockDataProvider>().updateQuantity(item.product.id, -1);
                              },
                              icon: const Icon(Icons.remove, size: 16),
                            ),
                            Text(item.quantity.toString().padLeft(2, '0'), style: Theme.of(context).textTheme.labelSmall),
                            IconButton(
                              onPressed: () {
                                context.read<MockDataProvider>().updateQuantity(item.product.id, 1);
                              },
                              icon: const Icon(Icons.add, size: 16),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.read<MockDataProvider>().removeFromCart(item.product.id);
                        },
                        icon: const Icon(Icons.delete_outline, size: 16, color: AppTheme.outline),
                        label: Text(
                          'REMOVE',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline, letterSpacing: 2.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
