import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDoingAction = false;
  bool _infiniyScroll = false;

  bool get isLoading => _isLoading;
  bool get isDoingAction => _isDoingAction;
  bool get infiniyScroll => _infiniyScroll;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setDoingAction(bool val) {
    _isDoingAction = val;
    notifyListeners();
  }

  void setInfiniyScroll(bool val) {
    _infiniyScroll = val;
    notifyListeners();
  }

  Future<void> asyncOperation(Future<void> Function() asyncFuture) async {
    try {
      setLoading(true);
      await asyncFuture();
    } on Exception catch (_) {
    } finally {
      setLoading(false);
    }
  }
}
