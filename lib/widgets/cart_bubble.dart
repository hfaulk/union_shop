import 'package:flutter/material.dart';

/// Small badge rendering count for a shopping cart icon.
class CartBubble extends StatelessWidget {
  final int count;
  final int maxDisplay;
  const CartBubble({super.key, required this.count, this.maxDisplay = 99});

  String _displayText() {
    if (count <= 0) return '';
    return count <= maxDisplay ? '$count' : '${maxDisplay}+';
  }

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    final txt = _displayText();
    return Semantics(
      label: 'Cart — $txt items',
      child: Container(
        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: Center(child: Text(txt, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
