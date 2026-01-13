import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/assets.dart';
import '../utils/core/extensions/extensions_export.dart';

class NoData extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? message;
  final String? buttonName;
  final IconData? icon;
  final String imagePath;

  const NoData({
    super.key,
    this.onPressed,
    this.message,
    this.buttonName,
    this.icon,
    this.imagePath = Assets.noData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imagePath, width: 250),
        const SizedBox(height: 10.0),
        Flexible(
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 15.0),
          ),
        ),
        const SizedBox(height: 10.0),
        if (buttonName == null)
          const SizedBox.shrink()
        else
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              label: Text(
                buttonName!,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: onPressed,
              icon: Icon(icon, color: Colors.white),
            ),
          ).paddingHV(h: MediaQuery.of(context).size.width * 0.1),
      ],
    );
  }
}
