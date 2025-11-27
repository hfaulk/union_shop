import 'package:flutter/material.dart';
import 'package:union_shop/view_models/cart_view_model.dart';

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
      appBar: AppBar(title: const Text('Your Cart')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: items
            .map((it) => ListTile(
                  title: Text(it.name),
                  subtitle: Text(
                      'Qty: ${it.quantity} • ${it.options.entries.map((e) => '${e.key}:${e.value}').join(', ')}'),
                ))
            .toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: vm == null || items.isEmpty
              ? null
              : () async {
                  await vm!.placeOrder();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order placed')));
                },
          child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Checkout')),
        ),
      ),
    );
  }
}
