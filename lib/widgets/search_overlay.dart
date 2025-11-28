import 'package:flutter/material.dart';

class SearchOverlay extends StatefulWidget {
  final VoidCallback? onClose;
  const SearchOverlay({Key? key, this.onClose}) : super(key: key);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Search'),
                  onChanged: (v) => setState(() => query = v),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.close), onPressed: widget.onClose),
            ],
          ),
        ),
      ),
    );
  }
}
