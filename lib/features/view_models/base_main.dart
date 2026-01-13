import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../stores/providers/main_provider.dart';

class ViewModel<T extends ChangeNotifier> extends ConsumerStatefulWidget {
  final T model;
  final ValueChanged<T>? onInitState;
  final Widget Function(T viewModel) builder;
  final bool performLoading;
  final bool isLazy;
  final Widget? loadingWidget;
  final ChangeNotifierProvider<T>? provider;

  const ViewModel({
    super.key,
    required this.builder,
    required this.model,
    this.onInitState,
    this.performLoading = false,
    this.loadingWidget,
    this.provider,
  }) : isLazy = false;

  const ViewModel.lazy({
    super.key,
    required this.builder,
    required this.model,
    this.onInitState,
    this.performLoading = false,
    this.loadingWidget,
    this.provider,
  }) : isLazy = true;

  @override
  ConsumerState<ViewModel<T>> createState() => _ViewModelState<T>();
}

class _ViewModelState<T extends ChangeNotifier>
    extends ConsumerState<ViewModel<T>> {
  late final ChangeNotifierProvider<T> _provider;

  @override
  void initState() {
    super.initState();
    _provider =
        widget.provider ?? ChangeNotifierProvider<T>((ref) => widget.model);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onInitState != null) {
        widget.onInitState!(ref.read(_provider));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(_provider);

    Widget buildContent(T model) {
      return Stack(
        children: [
          widget.builder(model),
          if (widget.performLoading &&
              (model is MainProvider && model.isLoading))
            Positioned.fill(
              child:
                  widget.loadingWidget ??
                  ColoredBox(
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

    return buildContent(viewModel);
  }
}
