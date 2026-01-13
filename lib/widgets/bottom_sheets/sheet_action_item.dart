import 'package:flutter/material.dart';

import 'action_style.dart';

class SheetActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final SheetActionItemStyle style;
  final bool autoDissmisable;

  const SheetActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.style = const SheetActionItemStyle(),
    this.autoDissmisable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 22.0, color: style.iconColor),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.5, color: style.titleColor),
      ),
      onTap: () {
        if (autoDissmisable) {
          Navigator.pop(context);
        }
        onTap();
      },
    );
  }
}
