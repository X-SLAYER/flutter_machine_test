import 'package:flutter/material.dart';
import '../constant/styles.dart';

class DevBanner extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final BannerLocation? location;
  final String message;
  final bool hidden;

  const DevBanner({
    super.key,
    this.child,
    this.color,
    this.location,
    this.message = 'Staging',
    this.hidden = true,
  });

  @override
  Widget build(BuildContext context) {
    return hidden
        ? child!
        : Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                Banner(
                  color: color ?? $styles.colors.accent1,
                  message: message,
                  location:
                      location != null ? location! : BannerLocation.bottomEnd,
                  textStyle: TextStyle(
                    color:
                        (HSLColor.fromColor(color ?? Colors.black).lightness <
                                0.8
                            ? Colors.white
                            : Colors.black87),
                    fontSize: 12.0 * 0.85,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                  child: child,
                ),
              ],
            ),
          );
  }
}
