import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/styles.dart';
import '../../../utils/core/extensions/extensions_export.dart';
import '../../../widgets/common/svg_icon.dart';
import '../../view_models/base_main.dart';
import 'home_view_model.dart';
import 'pages/my_requests/my_requests_screen.dart';
import 'pages/user_dashboard/user_dashboard.dart';
import 'pages/user_settings/user_settings_page.dart';
import 'utils/enums/drawer_items.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ViewModel<HomeViewModel>(
      model: HomeViewModel(),
      onInitState: (viewModel) {
        viewModel.pageController.addListener(() {
          viewModel.setCurrentIndex(
            viewModel.pageController.page?.toInt() ?? 0,
          );
        });
      },
      builder: (viewModel) {
        return Scaffold(
          body: PageView(
            controller: viewModel.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              UserDashboard(),
              MyRequestsScreen(),
              UserSettingsPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: $styles.colors.greyMedium,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: context.textTheme.bodyMedium,
            unselectedLabelStyle: context.textTheme.bodySmall,
            elevation: 0,
            currentIndex: viewModel.currentIndex,
            onTap: (index) {
              viewModel.pageController.jumpToPage(index);
            },
            items: DrawerItems.values
                .mapIndexed(
                  (index, e) => BottomNavigationBarItem(
                    icon: SvgIcon(
                      e.icon,
                      color: viewModel.currentIndex == index
                          ? $styles.colors.accent1
                          : $styles.colors.greyMedium,
                    ),
                    label: context.translate(e),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
