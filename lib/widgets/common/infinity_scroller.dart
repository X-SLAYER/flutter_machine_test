import 'package:flutter/material.dart';

import '../../utils/core/extensions/extensions_export.dart';

class InfiniteListView extends StatefulWidget {
  final VoidCallback onEndReached;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  const InfiniteListView({
    super.key,
    required this.onEndReached,
    required this.itemBuilder,
    required this.itemCount,
  });

  @override
  InfiniteListViewState createState() => InfiniteListViewState();
}

class InfiniteListViewState extends State<InfiniteListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.onEndReached();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    ).withNoGlowBehaviour();
  }
}
