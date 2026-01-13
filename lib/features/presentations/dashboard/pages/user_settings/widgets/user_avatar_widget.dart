import 'package:flutter/material.dart';

import '../../../../../../constant/assets.dart';
import '../../../../../../constant/styles.dart';
import '../../../../../../widgets/common/svg_icon.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.md),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: $styles.colors.accent1,
        shape: BoxShape.circle,
        boxShadow: $styles.shadows.cardShadow,
      ),
      child: SvgIcon(
        Assets.handShake,
        color: $styles.colors.white,
      ),
    );
  }
}
