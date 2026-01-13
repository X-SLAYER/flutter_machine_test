import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../../../constant/styles.dart';
import '../../../widgets/forms/invalid_feedback.dart';
import '../../app_utils/color_brightness.dart';
import 'string_extensions.dart';

extension ExtendPadding on Widget {
  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget paddingLRTB({
    double l = 0.0,
    double r = 0.0,
    double t = 0.0,
    double b = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: l, right: r, bottom: b, top: t),
      child: this,
    );
  }

  Widget paddingHV({double h = 0.0, double v = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
      child: this,
    );
  }
}

extension ExtendVisibilty on Widget {
  Widget visibleWhen(bool condition) {
    return condition ? this : const SizedBox.shrink();
  }
}

extension StateLayouts on Widget {
  Widget withStatusBar({Color color = Colors.white}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: ColorBrightness(color).matchedBrightness,
      ),
      child: this,
    );
  }

  Widget withErrorFeedback([String? feedback]) {
    return feedback != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              this,
              if (!feedback.isEmptyOrNull) ...[
                Gap($styles.insets.xs),
                InvalidFeedBack(feedback),
              ],
            ],
          )
        : this;
  }
}

extension Behaviour on Widget {
  Widget withNoGlowBehaviour() {
    return ScrollConfiguration(behavior: DragGlowBehaviour(), child: this);
  }
}

extension Skeleton on Widget {
  Widget toSkeleton([bool condition = true]) {
    return condition
        ? animate(onComplete: (ct) => ct.repeat(reverse: true)).shimmer(
            duration: $styles.times.slow,
            colors: [const Color(0xFFc8d3de), const Color(0xFFdfebf7)],
          )
        : this;
  }

  Widget withGradiantGlow({
    required Color baseColor,
    required Color highlightColor,
    bool when = true,
  }) {
    return when
        ? animate(onComplete: (ct) => ct.repeat(reverse: true)).shimmer(
            duration: $styles.times.med,
            colors: [baseColor, highlightColor],
          )
        : this;
  }

  Widget withLoading([bool isLoading = false]) {
    return Stack(
      children: [
        this,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class DragGlowBehaviour extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
