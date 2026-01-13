import 'package:flutter/material.dart';

import '../../../../../../utils/core/extensions/extensions_export.dart';

class QuickInfoTile extends StatelessWidget {
  const QuickInfoTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: context.reversedBackground,
      ),
      title: Text(title, style: context.textTheme.bodySmall),
      trailing: Text(value, style: context.textTheme.bodyMedium),
    );
  }
}
