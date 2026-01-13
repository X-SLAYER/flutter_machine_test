import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Position {
  top,
  bottom,
}

class Iosish {
  final BuildContext _context;

  final double _statusBarHeight;

  OverlayState? _overlay;

  Iosish(this._context)
    : _statusBarHeight = MediaQuery.of(_context).padding.top;

  void createIndicator({
    required String title,
    Position position = Position.top,
    Duration? duration,
    bool haptic = true,
    Widget? child,
  }) {
    _overlay = Overlay.of(_context);

    final OverlayEntry entry = OverlayEntry(
      builder: (context) => _Indicator(
        title: title,
        duration: duration ?? const Duration(seconds: 2),
        position: position,
        haptic: haptic,
        statusBarHeight: _statusBarHeight,
        child: child,
      ),
    );

    _overlay?.insert(entry);

    _removeEntry(entry, duration ?? const Duration(seconds: 2));
  }

  Future<void> _removeEntry(OverlayEntry entry, Duration duration) async {
    await Future.delayed(duration + const Duration(milliseconds: 600));
    entry.remove();
  }
}

class _Indicator extends StatefulWidget {
  final double statusBarHeight;

  final String title;

  final Duration duration;

  final Position position;

  final bool haptic;

  final Widget? child;

  const _Indicator({
    required this.statusBarHeight,
    required this.title,
    required this.duration,
    required this.position,
    required this.haptic,
    this.child,
  });

  @override
  State<StatefulWidget> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> {
  static const double _beginPosition = -64;

  static final double _finishPosition = Platform.isIOS ? 120 : 100;

  double? _currentPos;

  Future<void> startMove() async {
    _currentPos = _beginPosition;

    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      _currentPos = _finishPosition - widget.statusBarHeight;
    });

    endMove();
  }

  Future<void> endMove() async {
    await Future.delayed(widget.duration);

    setState(() {
      _currentPos = _beginPosition;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.haptic) {
      HapticFeedback.heavyImpact();
    }

    startMove();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: widget.position == Position.top ? _currentPos : null,
          bottom: widget.position == Position.bottom ? _currentPos : null,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 16,
                right: 32,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Row(
                children: [
                  widget.child ?? const SizedBox(),
                  const SizedBox(width: 16),
                  Flexible(
                    child: AutoSizeText(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
