import 'package:flutter/material.dart';

/// Small badge rendering count for a shopping cart icon.
class CartBubble extends StatelessWidget {
  final int count;
  final int maxDisplay;
  const CartBubble({super.key, required this.count, this.maxDisplay = 99});

  String _displayText() {
    if (count <= 0) return '';
    return count <= maxDisplay ? '$count' : '$maxDisplay+';
  }

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    final txt = _displayText();
    final label = (txt == '1') ? 'Cart — 1 item' : 'Cart — $txt items';
    return Semantics(
      label: label,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeInBack,
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Container(
          key: ValueKey(txt),
          constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration:
              const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Center(
              child: Text(txt,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}
