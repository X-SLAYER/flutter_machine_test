import 'package:flutter/widgets.dart';

import '../../../stores/providers/main_provider.dart';

class HomeViewModel extends MainProvider {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  PageController pageController = PageController();

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
