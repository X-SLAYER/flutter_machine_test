import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension RandomListItem<T> on List<T> {
  T randomItem([String? current]) {
    final T randomOne = (List.from(this)..shuffle()).first;
    if (current != null) {
      if (randomOne == current) {
        return (List.from(this)..shuffle()).last;
      }
    }
    return randomOne;
  }
}

extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}

extension GapPackageListExtension<T extends Widget> on List<T> {
  List<Widget> gap(double mainAxisExtent) {
    return _gap(mainAxisExtent).toList();
  }

  List<Widget> expanded() => _expand().toList();

  List<Widget> flex() => _flex().toList();

  Iterable<Widget> _expand() sync* {
    for (final widget in this) {
      yield Expanded(child: widget);
    }
  }

  Iterable<Widget> _flex() sync* {
    for (final widget in this) {
      yield Flexible(child: widget);
    }
  }

  Iterable<Widget> _gap(double mainAxisExtent) sync* {
    final maxIndex = length - 1;
    for (var i = 0; i <= maxIndex; i++) {
      yield elementAt(i);
      if (i != maxIndex) {
        yield Gap(mainAxisExtent);
      }
    }
  }
}
