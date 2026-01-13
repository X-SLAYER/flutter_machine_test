import 'package:flutter/material.dart';

import '../../../constant/assets.dart';
import '../../../constant/styles.dart';
import '../../view_models/base_main.dart';
import 'splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModel<SplashViewModel>(
      model: SplashViewModel(),
      onInitState: (viewModel) {
        viewModel.init();
      },
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: $styles.colors.accent1,
          body: Center(
            child: Image.asset(
              Assets.appLogo,
              width: 250,
              height: 250,
            ),
          ),
        );
      },
    );
  }
}
