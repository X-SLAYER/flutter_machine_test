import 'package:flutter/material.dart';
import '../no_data.dart';

class FutureWidget<T> extends StatefulWidget {
  final Future<T> future;
  final Widget? loader;
  final Widget? error;
  final Widget Function(T data) builder;

  const FutureWidget({
    super.key,
    required this.future,
    required this.builder,
    this.loader,
    this.error,
  });

  @override
  State<FutureWidget<T>> createState() => _FutureWidgetState<T>();
}

class _FutureWidgetState<T> extends State<FutureWidget<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loader ??
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return widget.error ??
              Center(
                child: NoData(
                  message: snapshot.error.toString(),
                ),
              );
        } else {
          return widget.builder(snapshot.data as T);
        }
      },
    );
  }
}
