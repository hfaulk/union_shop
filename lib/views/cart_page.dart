import 'package:flutter/material.dart';
import 'package:union_shop/view_models/cart_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    appCartViewModel?.addListener(_onChange);
  }

  void _onChange() => setState(() {});

  @override
  void dispose() {
    appCartViewModel?.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = appCartViewModel;
    final items = vm?.items ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart'), actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () async {
            final ctx = context;
            final prefs = await SharedPreferences.getInstance();
            final s = prefs.getString('cart_items_v1') ?? '<none>';
            if (!mounted) return;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  context: ctx,
                  builder: (c) => AlertDialog(
                        title: const Text('Saved cart (prefs)'),
                        content: SingleChildScrollView(child: Text(s)),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(c),
                              child: const Text('Close'))
                        ],
                      ));
            });
          },
        )
      ]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: items
            .map((it) => ListTile(
                  title: Text(it.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(it.options.entries
                          .map((e) => '${e.key}:${e.value}')
                          .join(', ')),
                      const SizedBox(height: 4),
                      Text(
                          'Price: £${it.price.toStringAsFixed(2)} • Subtotal: £${(it.price * it.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () async {
                          final vm = appCartViewModel;
                          if (vm != null) {
                            final messenger = ScaffoldMessenger.of(context);
                            await vm.updateQuantity(it.id, it.quantity - 1);
                            if (!mounted) return;
                            messenger.showSnackBar(const SnackBar(
                                content: Text('Quantity updated')));
                          }
                        }),
                    Text('${it.quantity}'),
                    IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () async {
                          final vm = appCartViewModel;
                          if (vm != null) {
                            final messenger = ScaffoldMessenger.of(context);
                            await vm.updateQuantity(it.id, it.quantity + 1);
                            if (!mounted) return;
                            messenger.showSnackBar(const SnackBar(
                                content: Text('Quantity updated')));
                          }
                        }),
                    IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () async {
                          final vm = appCartViewModel;
                          if (vm != null) {
                            final messenger = ScaffoldMessenger.of(context);
                            await vm.removeItemById(it.id);
                            if (!mounted) return;
                            messenger.showSnackBar(
                                const SnackBar(content: Text('Removed item')));
                          }
                        }),
                  ]),
                ))
            .toList(),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12.0),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Totals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(
                    '£${items.fold<double>(0, (s, it) => s + it.price * it.quantity).toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: vm == null || items.isEmpty
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                                title: const Text('Confirm order'),
                                content: const Text('Place this order?'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(c, false),
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () => Navigator.pop(c, true),
                                      child: const Text('Confirm')),
                                ],
                              ));
                      if (confirmed == true) {
                        await vm.placeOrder();
                        if (!mounted) return;
                        messenger.showSnackBar(
                            const SnackBar(content: Text('Order placed')));
                      }
                    },
              child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Checkout')),
            ),
          ],
        ),
      ),
    );
  }
}
